package com.hrg.module.project;

import com.hrg.model.Project;
import com.hrg.model.ProjectCriteria;
import com.hrg.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * Created by 82705 on 2017/6/14.
 */
@Controller
public class ProjectController {

    @Autowired
    ProjectService projectService;

    @RequestMapping(value = "/projectList")
    public ModelAndView selectProject(){
        ModelAndView modelAndView=new ModelAndView();
        modelAndView.setViewName("project_list");
        try {
            ProjectCriteria projectCriteria=new ProjectCriteria();
            List<Project> projectList= projectService.selectList(projectCriteria);
            modelAndView.addObject("projectList",projectList);
        }catch (Exception e){
            e.printStackTrace();
        }
        return modelAndView;
    }
}
