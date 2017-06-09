package com.hrg.module.worker;

import com.hrg.enums.ErrorCode;
import com.hrg.global.JsonResult;
import com.hrg.model.Worker;
import com.hrg.service.ShiroRealmService;
import com.hrg.util.ResultUtil;
import com.hrg.util.SubjectUtil;
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

import javax.servlet.ServletRequest;
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

    private static Logger logger = Logger.getLogger("LoginController");

    @RequestMapping("/hellow")
    public String login(){
        return "login";
    }

    @ResponseBody
    @RequestMapping("/login")
    public JsonResult workerLogin(HttpServletRequest request) {
        JsonResult jr = null;
        String exceptionClassName = (String) request.getAttribute("shiroLoginFailure");
        if (exceptionClassName != null) {
            if (UnknownAccountException.class.getName().equals(exceptionClassName)) {
                logger.info("=============登录失败，用户名错误=============");
                jr = ResultUtil.returnFail(ErrorCode.ACCOUNT_NON_EXISTEND.getCode(), ErrorCode.ACCOUNT_NON_EXISTEND.getMessage());
            } else if (IncorrectCredentialsException.class.getName().equals(exceptionClassName)) {
                logger.info("=============登录失败，密码错误=============");
                jr = ResultUtil.returnFail(ErrorCode.ACCOUNT_PASSWORD_ERROR.getCode(), ErrorCode.ACCOUNT_PASSWORD_ERROR.getMessage());
            } else if (LockedAccountException.class.getName().equals(exceptionClassName)) {
                logger.info("=============登录失败，用户被锁定=============");
                jr = ResultUtil.returnFail(ErrorCode.ACCOUNT_TYPE_EXCEPTION.getCode(), ErrorCode.ACCOUNT_TYPE_EXCEPTION.getMessage());
            } else {
                logger.error("=============登录失败失败，系统异常=============");
                jr = ResultUtil.returnFail(ErrorCode.UN_KNOWN_EXCEPTION.getCode(), ErrorCode.UN_KNOWN_EXCEPTION.getMessage());
            }
        } else {
            try {
                SubjectUtil.getAccout();
                logger.error("=============你已经登录，若需登录其他账号，请先退出当前账号===========");
                jr = ResultUtil.returnSuccess("你已经登录，若需登录其他账号，请先退出当前账号");
            } catch (Exception e) {
                logger.info("================请先登录==============");
                jr = ResultUtil.returnFail(ErrorCode.NOT_LOGIN_EXCEPTION.getCode(), ErrorCode.NOT_LOGIN_EXCEPTION.getMessage());
            }
        }
        return jr;
    }

    @RequestMapping("/success")
    public ModelAndView success(){
        Worker worker = null;
        ModelAndView model = new ModelAndView();
        model.setViewName("index");
        try {
            logger.info("=============开始查询员工权限=============");
            worker = (Worker) SecurityUtils.getSubject().getPrincipal();
            //根据员工主键查询员工账套
            List<? extends Object> WarehouseRoleRelPermission = shiroRealmService.getPermissionByUser(worker);
            Map<String, Object> workerAllInfo = new HashMap<String, Object>();
            workerAllInfo.put("workerInfo", worker);
            workerAllInfo.put("workerpermissions", WarehouseRoleRelPermission);
            model.addObject("workerInfo",worker);
            model.addObject("workerpermissions",WarehouseRoleRelPermission);
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
}