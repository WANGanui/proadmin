package com.hrg.module.mission;

import com.hrg.enums.ErrorCode;
import com.hrg.exception.ValidatorException;
import com.hrg.global.ApiResult;
import com.hrg.model.*;
import com.hrg.service.MissionService;
import com.hrg.service.ProjectService;
import com.hrg.util.JsonUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * Created by 82705 on 2017/6/7.
 */
@Controller
public class MissionController {
    private static Logger logger = Logger.getLogger("MissionController");

    @Autowired
    MissionService missionService;
    @Autowired
    ProjectService projectService;

    @RequestMapping("/missionList")
    public ModelAndView selectList(HttpServletRequest request, MissionCriteria example){
        ModelAndView model = new ModelAndView();
        try {
            logger.info("============开始任务列表查询=============");
            logger.info("============入参【"+ JsonUtil.encode(example)+"】=============");
            List<Mission> missions = missionService.selectList(example);
            logger.info("============任务列表查询成功=============");
            model.addObject("list",missions);
            model.setViewName("mission/mission_list");
        } catch (Exception e) {
            logger.info("============任务列表查询失败，系统异常=============");
            model.addObject(JsonUtil.encode(ApiResult.returnFail(ErrorCode.SYSTEM_EXCEPTION.getMessage(),ErrorCode.SYSTEM_EXCEPTION.getCode())));
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/workermission")
    public ModelAndView selectWokerMission(MissionCriteria example,HttpServletRequest request){
        ModelAndView model = new ModelAndView();
        HttpSession session = request.getSession();
        Worker worker = (Worker)session.getAttribute("worker");
        try {
            logger.info("============开始个人任务列表查询=============");
            logger.info("============入参【"+ JsonUtil.encode(example)+"】=============");
            Map<String,Object> map = missionService.slectWorkerMission(example,worker.getDataid());
            model.addObject("map",map);
            model.setViewName("mission/worker_miss_list");
            logger.info("============个人任任务列表查询成功=============");
        }catch (ValidatorException v){
            model.addObject(JsonUtil.encode(ApiResult.returnFail(ErrorCode.INCOMPLETE_REQ_PARAM.getMessage(),ErrorCode.INCOMPLETE_REQ_PARAM.getCode())));
            logger.info("============个人任务列表查询失败，验证异常=============");
            v.printStackTrace();
        } catch (Exception e) {
            logger.info("============个人任务列表查询失败，系统异常=============");
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/missionAdd")
    public ModelAndView gotoAdd(){
        ModelAndView model = new ModelAndView();
        try {
            List<Project> list = projectService.selectList(new ProjectCriteria());
            model.addObject("list",list);
            model.setViewName("mission/mission_add");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }
}
