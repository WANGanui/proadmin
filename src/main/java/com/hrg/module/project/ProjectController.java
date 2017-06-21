package com.hrg.module.project;

import com.hrg.model.*;
import com.hrg.service.DepartmentService;
import com.hrg.service.ProjectService;
import com.hrg.service.WorkerService;
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
import java.util.List;

/**
 * Created by 82705 on 2017/6/14.
 */
@Controller
public class ProjectController {

    private static Logger logger = Logger.getLogger("ProjectController");
    @Autowired
    ProjectService projectService;

    @Autowired
    WorkerService workerService;//根据部门查询员工

    @Autowired
    DepartmentService departmentService;//查询所有部门
    //查询项目列表
    @RequestMapping(value = "/projectList")
    public String selectProject(HttpServletRequest request){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("project_list");
        try {
            ProjectCriteria projectCriteria=new ProjectCriteria();
            List<Project> projectList= projectService.selectList(projectCriteria);
logger.info("=========================================:"+ JsonUtil.encode(projectList));
            request.setAttribute("projectList",projectList);/*
            modelAndView.addObject("projectList",projectList);*/
        }catch (Exception e){
            e.printStackTrace();
        }
        return "project/project_list";
    }

    @RequestMapping(value = "/projectAdd")
    public  String projectAdd(HttpServletRequest request){
        DepartmentCriteria departmentCriteria=new DepartmentCriteria();
        try {
            List<Department> departmentList= departmentService.selectList(departmentCriteria);
            request.setAttribute("departmentList",departmentList);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "project/project_add";
    }


    //创建项目
    @RequestMapping(value = "/addProject")
    public @ResponseBody Object addProject(HttpSession session, @RequestBody Project project){
        //getDays
        Worker worker=(Worker) session.getAttribute("worker");
        String creatordataid= worker.getDataid();//创建人ID
        String creator=worker.getName();//创建人
        return "";
    }
}
