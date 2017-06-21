package com.hrg.module.mission;

import com.hrg.enums.ErrorCode;
import com.hrg.global.ApiResult;
import com.hrg.model.Mission;
import com.hrg.model.MissionCriteria;
import com.hrg.service.MissionService;
import com.hrg.util.JsonUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by 82705 on 2017/6/7.
 */
@Controller
public class MissionController {
    private static Logger logger = Logger.getLogger("MissionController");

    @Autowired
    MissionService missionService;

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
}
