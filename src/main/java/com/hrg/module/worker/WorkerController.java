package com.hrg.module.worker;

import com.hrg.enums.ErrorCode;
import com.hrg.exception.MessageException;
import com.hrg.exception.ValidatorException;
import com.hrg.global.ApiResult;
import com.hrg.global.JsonResult;
import com.hrg.model.Module;
import com.hrg.model.ModuleCriteria;
import com.hrg.model.Worker;
import com.hrg.model.WorkerCriteria;
import com.hrg.service.ModuleService;
import com.hrg.service.ShiroRealmService;
import com.hrg.service.WorkerService;
import com.hrg.util.JsonUtil;
import com.hrg.util.PageUtil;
import com.hrg.util.ResultUtil;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
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
    private ShiroRealmService shiroRealmService;
    @Autowired
    private WorkerService workerService;
    @Autowired
    private ModuleService moduleService;


    private static Logger logger = Logger.getLogger("LoginController");

    @RequestMapping("/hellow")
    public String login(){
        return "login";
    }

    @ResponseBody
    @RequestMapping("/login")
    public ModelAndView workerLogin(HttpServletRequest request) {
        JsonResult jr = null;
        ModelAndView model = new ModelAndView();
        String exceptionClassName = (String) request.getAttribute("shiroLoginFailure");
        if (exceptionClassName != null) {
            if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
                logger.info("=============登录失败，用户名错误=============");
                model.addObject(JsonUtil.encode(ApiResult.returnFail(ErrorCode.ACCOUNT_NON_EXISTEND.getMessage(),ErrorCode.ACCOUNT_NON_EXISTEND.getCode())));
                model.setViewName("login");
            } else if (IncorrectCredentialsException.class.getName().equals(exceptionClassName)) {
                logger.info("=============登录失败，密码错误=============");
                model.addObject(JsonUtil.encode(ApiResult.returnFail(ErrorCode.ACCOUNT_PASSWORD_ERROR.getMessage(),ErrorCode.ACCOUNT_PASSWORD_ERROR.getCode())));
                model.setViewName("login");
            } else if (LockedAccountException.class.getName().equals(exceptionClassName)) {
                logger.info("=============登录失败，用户被锁定=============");
                model.addObject(JsonUtil.encode(ApiResult.returnFail(ErrorCode.ACCOUNT_TYPE_EXCEPTION.getMessage(),ErrorCode.ACCOUNT_TYPE_EXCEPTION.getCode())));
                model.setViewName("login");
            } else {
                logger.error("=============登录失败失败，系统异常=============");
                model.addObject(JsonUtil.encode(ApiResult.returnFail(ErrorCode.UN_KNOWN_EXCEPTION.getMessage(),ErrorCode.UN_KNOWN_EXCEPTION.getCode())));
                model.setViewName("login");
            }
        } else {

        }
        return model;
    }

    @RequestMapping("/success")
    public ModelAndView success(){
        Worker worker = null;
        ModelAndView model = new ModelAndView();
        try {
            model.setViewName("index/main");
            logger.info("=============开始查询员工权限=============");
            worker = (Worker) SecurityUtils.getSubject().getPrincipal();
            model.addObject("worker",worker);
            if (worker.getDataid()=="1" || worker.getDataid().equals("1")){
                List<Module> module = null;
                module = moduleService.selectList(new ModuleCriteria());
                model.addObject("menus",module);
            }
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
    public ModelAndView logout(){
        ModelAndView model = new ModelAndView();
        logger.info("=============退出登录=============");
        Subject subject = SecurityUtils.getSubject();
        if (subject.isAuthenticated()) {

            Worker worker = (Worker) subject.getPrincipal();
            subject.logout();
            logger.info("=============用户【" + worker.getName() + "】退出登录=============");
            model.addObject(ResultUtil.returnSuccess("用户成功退出"));
        } else {
            logger.error("=============退出失败,系统异常=============");
            model.addObject(ResultUtil.returnFail(ErrorCode.UN_KNOWN_EXCEPTION.getCode()));
        }
        model.setViewName("login");
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
    public ModelAndView editPass(String userID,String password,String newPassword){
        ModelAndView model = new ModelAndView();
        Worker worker = new Worker();
        try {
            logger.info("===========进入修改密码===========");
            worker.setDataid(userID);
            Worker worker1 = workerService.selectDetail(userID);
            logger.info("===========开始验证旧密码===========");
            if (!password.equals(worker1.getPassword())){
                logger.error("============原密码不匹配============");
            }else {
                worker.setPassword(newPassword);
                workerService.update(worker);
                logger.info("=========密码修改成功=========");
                model.addObject(JsonUtil.encode(ApiResult.returnSuccess()));
            }
        } catch (Exception e) {
            logger.info("===========密码修改失败，系统异常===========");
            model.addObject(JsonUtil.encode(ApiResult.returnFail(ErrorCode.MESSAGE_EXCEPTION.getMessage(),ErrorCode.MESSAGE_EXCEPTION.getCode())));
            e.printStackTrace();
        }
        return model;
    }

    @ResponseBody
    @RequestMapping(value = "/list" ,method = RequestMethod.GET)
    public ModelAndView workerList(PageUtil pageUtil, WorkerCriteria example){
        ModelAndView model = new ModelAndView();

        try {
            logger.info("============查询员工列表入参：【"+JsonUtil.encode(example)+"】==============");
            PageUtil<Worker> pageUtil1 = workerService.selectByExample(example,pageUtil);
            logger.info("=============查询员工列表成功,结果:【 " + JsonUtil.encode(pageUtil1) + "】=============");
            model.addObject("data",JsonUtil.encode(pageUtil1));
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
}