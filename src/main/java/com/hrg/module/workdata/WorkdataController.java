package com.hrg.module.workdata;

import com.hrg.model.Project;
import com.hrg.model.Workdata;
import com.hrg.model.WorkdataCriteria;
import com.hrg.model.Worker;
import com.hrg.service.MissionService;
import com.hrg.service.ProjectService;
import com.hrg.service.WorkDataService;
import com.hrg.util.JsonUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 82705 on 2017/6/21.
 */
@Controller
public class WorkdataController {
    private static Logger logger = Logger.getLogger("WorkdataController");

    @Autowired
    WorkDataService workDataService;
    @Autowired
    ProjectService projectService;
    @Autowired
    MissionService missionService;

    @RequestMapping("/missionWorkdata")
    public ModelAndView selectList(WorkdataCriteria example, HttpServletRequest request){
        ModelAndView model = new ModelAndView();
        HttpSession session = request.getSession();
        Worker worker = (Worker) session.getAttribute("worker");
        try {
            logger.info("===========开始查询工作日志，入参【"+ JsonUtil.encode(example)+"】============");
            List<Workdata> list = workDataService.selectList(example,worker.getDepartmentdataid());
            model.addObject("list",list);
            model.setViewName("workdata/data_list");
            logger.info("============查询日志成功==============");
        } catch (Exception e) {
            logger.info("============查询日志失败==============");
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/workerdata")
    public ModelAndView selectWorkerdataList(HttpServletRequest request,WorkdataCriteria example){
        ModelAndView model = new ModelAndView();
        HttpSession session = request.getSession();
        Worker worker = (Worker)session.getAttribute("worker");
        example.setWorkerdataid(worker.getDataid());
        logger.info("============开始查询个人日志==============");
        try {
            logger.info("===========开始查询个人日志，入参【"+ JsonUtil.encode(example)+"】============");
            List<Workdata> list = workDataService.selectList(example,null);
            model.addObject("list",list);
            model.setViewName("workdata/workerdata_list");
            logger.info("=================查询日志成功=====================");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/workdataADdd")
    public ModelAndView addworkData(HttpServletRequest request){
        ModelAndView model = new ModelAndView();
        HttpSession session = request.getSession();
        Worker worker = (Worker) session.getAttribute("worker");
        try {
            List<Project> projectList = projectService.selectByWorker(worker.getDataid());
            model.addObject("projects",projectList);
            model.setViewName("workdata/data_add");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/addWorkdata")
    public @ResponseBody Object addWorkdata(HttpSession session, @RequestBody Workdata workdata){
        Map map = new HashMap();
        Worker worker = (Worker)session.getAttribute("worker");
        workdata.setWorkerdataid(worker.getDataid());
        workdata.setWorkername(worker.getName());
        try {
            workDataService.insert(workdata);
            map.put("success",true);
        } catch (Exception e) {
            map.put("success",false);
            e.printStackTrace();
        }
        return map;
    }
}
