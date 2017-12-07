package com.hrg.module.worker;

import com.hrg.enums.ErrorCode;
import com.hrg.exception.MessageException;
import com.hrg.exception.ValidatorException;
import com.hrg.global.ApiResult;
import com.hrg.global.JsonResult;
import com.hrg.model.Worker;
import com.hrg.model.WorkerCriteria;
import com.hrg.service.ModuleService;
import com.hrg.service.PermissionService;
import com.hrg.service.WorkerService;
import com.hrg.util.JsonUtil;
import com.hrg.util.ResultUtil;
import com.hrg.util.ValidUtil;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 82705 on 2017/6/6.
 */
@Controller
@RequestMapping("/worker")
public class WorkerController {


    @Autowired
    private WorkerService workerService;
    @Autowired
    private ModuleService moduleService;
    @Autowired
    PermissionService permissionService;

    private static Logger logger = Logger.getLogger("LoginController");

    @RequestMapping("/hellow")
    public String login(){
        return "login";
    }

    @ResponseBody
    @RequestMapping("/login")
    public Object workerLogin(HttpServletRequest request) {
        JsonResult jr = null;
        HttpSession session = request.getSession();
        String account = request.getParameter("username");
        try {
            Worker worker =  workerService.getWorkerInfo(account);
            if (ValidUtil.isNullOrEmpty(worker)){
                logger.info("=============账号不存在=============");
                return JsonUtil.encode(ApiResult.returnFail(ErrorCode.ACCOUNT_NON_EXISTEND.getMessage(),ErrorCode.ACCOUNT_NON_EXISTEND.getCode()));
            }else{
                if (!worker.getPassword().equals(request.getParameter("password"))){
                    logger.info("==============密码不正确=================");
                    return JsonUtil.encode(ApiResult.returnFail(ErrorCode.ACCOUNT_PASSWORD_ERROR.getMessage(),ErrorCode.ACCOUNT_NON_EXISTEND.getCode()));
                }else if (worker.getState()=="0" || worker.getState().equals("0")){
                    logger.info("==============账号被锁定=============");
                    return JsonUtil.encode(ApiResult.returnFail(ErrorCode.ACCOUNT_TYPE_EXCEPTION.getMessage(),ErrorCode.ACCOUNT_TYPE_EXCEPTION.getCode()));
                }else {
                    logger.info("=============登录成功=============");
                    session.setAttribute("worker",worker);
                    return JsonUtil.encode(ApiResult.returnSuccess());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @RequestMapping("/success")
    public ModelAndView success(HttpServletRequest request){
        ModelAndView model = new ModelAndView();
        HttpSession session = request.getSession();
        Worker worker = (Worker) session.getAttribute("worker");
        try {
            model.setViewName("index/main");
            logger.info("=============开始查询员工权限=============");
            model.addObject("worker",worker);
            Map<String, Object> map = workerService.selectModuleAndPermission(worker.getDataid());
            model.addObject("map",map);
            logger.info("=============查询员工权限完成=============");
        } catch (NullPointerException exception) {
            logger.error("=============查询员工权限失败，员工身份过期=============");
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("=============查询员工权限失败，系统异常=============");
        }
        return model;
    }

    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public ModelAndView logout(HttpServletRequest request){
        ModelAndView model = new ModelAndView();
        logger.info("=============退出登录=============");
        HttpSession session = request.getSession();
        Worker worker = (Worker)session.getAttribute("worker");
        if (!ValidUtil.isNullOrEmpty(worker)) {
            session.removeAttribute("worker");
            logger.info("=============用户【" + worker.getName() + "】退出登录=============");
            model.addObject(ResultUtil.returnSuccess("用户成功退出"));
            model.setViewName("login");
        } else {
            logger.error("=============用户已进退出=============");
            model.setViewName("login");
        }
        return model;
    }

    @RequestMapping(value = "/unauthorized",method = RequestMethod.POST)
    public JsonResult unauthorized(){
        JsonResult jr = null;
        logger.info("=============该员工没有此权限=============");
        jr = ResultUtil.returnFail(ErrorCode.UN_KNOWN_EXCEPTION.getCode(), "该员工没有此权限");
        return jr;
    }

    @ResponseBody
    @RequestMapping(value = "/isLogin", method = RequestMethod.POST)
    public JsonResult isLogin() {
        JsonResult jr = null;
        try {
            logger.info("=============校验员工是否为已登陆=============】");
            Subject subject = SecurityUtils.getSubject();
            Boolean islogin = true;
            islogin=(subject.getPrincipal()!=null?true:false);
            if (islogin) {
                jr = ResultUtil.returnSuccess();
                logger.info("=============员工已登陆成功=============");
            } else {
                logger.error("=============员工未登陆，未登录异常=============");
                jr = ResultUtil.returnFail(ErrorCode.NOT_LOGIN_EXCEPTION.getCode());
            }
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("=============校验员工是否为已登陆失败，系统异常=============");
            jr = ResultUtil.returnFail(ErrorCode.UN_KNOWN_EXCEPTION.getCode());
        }
        return jr;
    }

    @ResponseBody
    @RequestMapping("/password")
    public ModelAndView password(String userID){
        ModelAndView model = new ModelAndView();
        Worker worker = null;
        try {
            worker = workerService.selectDetail(userID);
            model.setViewName("worker/password");
            model.addObject("data",JsonUtil.encode(worker));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }

    @ResponseBody
    @RequestMapping(value = "/editPass" ,method = RequestMethod.POST)
    public Object editPass(HttpSession session,@RequestBody Map map){
        Map model = new HashMap();
        Worker worker = (Worker)session.getAttribute("worker");
        try {
            String password = map.get("password").toString();
            String newPassword = map.get("newPassword").toString();
            logger.info("===========进入修改密码===========");
            Worker worker1 = workerService.selectDetail(worker.getDataid());
            logger.info("===========开始验证旧密码===========");
            if (!password.equals(worker1.getPassword())){
                logger.error("============原密码不匹配============");
                model.put("success",false);
            }else {
                worker.setPassword(newPassword);
                workerService.update(worker);
                logger.info("=========密码修改成功=========");
                model.put("success",true);
            }
        } catch (Exception e) {
            logger.info("===========密码修改失败，系统异常===========");
            e.printStackTrace();
        }
        return model;
    }

    @ResponseBody
    @RequestMapping(value = "/list" ,method = RequestMethod.GET)
    public ModelAndView workerList( WorkerCriteria example,String roleid){
        ModelAndView model = new ModelAndView();
        try {
            logger.info("============查询员工列表入参：【"+JsonUtil.encode(example)+"】==============");
            List<Worker> workerList = workerService.selectList(example);
            logger.info("=============查询员工列表成功,结果:【 " + JsonUtil.encode(workerList) + "】=============");
            List<String> missList = permissionService.selectList("14",roleid);
            model.addObject("list",workerList);
            model.addObject("roles",missList);
            model.setViewName("worker/worker_list");
        } catch (ValidatorException e) {
            logger.warn("=============查询员工列表失败，验证异常=============");
            model.addObject(ApiResult.returnFail(ErrorCode.ILLEGALARGUMENT_EXCEPTION.getMessage(),ErrorCode.ILLEGALARGUMENT_EXCEPTION.getCode()));
        } catch (MessageException e) {
            logger.warn("=============查询员工列表失败，信息异常=============");
            model.addObject(ApiResult.returnFail(ErrorCode.MESSAGE_EXCEPTION.getMessage(),ErrorCode.MESSAGE_EXCEPTION.getCode()));
        } catch (Exception e) {
            logger.error("=============查询员工列表失败，系统异常=============", e);
            model.addObject(ApiResult.returnFail(ErrorCode.UN_KNOWN_EXCEPTION.getMessage(),ErrorCode.UN_KNOWN_EXCEPTION.getCode()));
        }
        return model;
    }

    @RequestMapping("/add")
    public ModelAndView toaddWorker(){
        ModelAndView model = new ModelAndView();
        try {
            Map map = workerService.selectRoleAndPartment();
            model.addObject("map",map);
            model.setViewName("worker/worker_add");
        } catch (Exception e) {
            e.printStackTrace();
        }

        return model;
    }

    @RequestMapping("/addWorker")
    public @ResponseBody Object addWorker(@RequestBody Worker worker){
        Map map = new HashMap();
        try {
            if (worker.getState().equals("on"))
                worker.setState("1");
            else {
                worker.setState("0");
            }
           boolean bool = workerService.insert(worker,worker.getRoleid());
            if (bool)
                map.put("success",true);
            else
                map.put("success",false);
        } catch (Exception e) {
            map.put("success",false);
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping("/editWorker")
    public ModelAndView editworker(String dataid){
        ModelAndView model = new ModelAndView();
        try {
            Worker worker = workerService.selectDetail(dataid);
            Map map = workerService.selectRoleAndPartment();
            Map map1 = workerService.selectWorkerRole(dataid);
            model.addObject("mmp",map1);
            model.addObject("map",map);
            model.addObject("user",worker);
            model.setViewName("worker/worker_edit");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/updataWorker")
    public @ResponseBody Object updateWorker(@RequestBody Worker worker){
        Map map = new HashMap();
        try {
            if (worker.getState()!=null)
                worker.setState("1");
            else {
                worker.setState("0");
            }
            boolean bool = workerService.updateWorkerandRole(worker,worker.getRoleid());
            if (bool)
                map.put("success",true);
            else
                map.put("success",false);
        } catch (Exception e) {
            map.put("success",false);
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping("/deleteWorker")
    public @ResponseBody Object deleteWorker(@RequestBody Map remap) {
        Map map = new HashMap();
        try {
            String dataid = remap.get("dataid").toString();
            boolean bool = workerService.delete(dataid);
            if (bool)
                map.put("success",true);
            else
                map.put("success",false);
        } catch (Exception e) {
            map.put("success",false);
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping("/selectIndex")
    public ModelAndView selectIndex(String dataid,HttpSession session){
        Worker worker = (Worker) session.getAttribute("worker");
        ModelAndView model = new ModelAndView();
        try {
            Map map = workerService.selectIndex(dataid,worker);
            model.addObject("map",map);
            model.setViewName("index/welcome");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/selectyeji")
    public @ResponseBody Object selectyeji(HttpSession session){
        Worker worker = (Worker) session.getAttribute("worker");
        Map map = new HashMap();
        try {
            List list = workerService.slectyeji(worker);
            map.put("yejiList",list);
            map.put("success",true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }
}