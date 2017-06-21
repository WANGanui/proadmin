package com.hrg.module.project;

import com.hrg.model.Project;
import com.hrg.model.ProjectCriteria;
import com.hrg.service.ProjectService;
import com.hrg.util.JsonUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by 82705 on 2017/6/14.
 */
@Controller
public class ProjectController {

    private static Logger logger = Logger.getLogger("ProjectController");
    @Autowired
    ProjectService projectService;

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
        return "project_list";
    }
}
