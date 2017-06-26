package com.hrg.module.project;

import com.hrg.model.*;
import com.hrg.service.*;
import com.hrg.util.JsonUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
    @Autowired
    WorkDataService workDataService; //查询项目进度详情
    @Autowired
    PermissionService permissionService;
    //查询项目列表
    @RequestMapping(value = "/projectList")
    public String selectProject(HttpServletRequest request,String roleid){
        try {
            ProjectCriteria projectCriteria=new ProjectCriteria();
            List<Project> projectList= projectService.selectList(projectCriteria);
logger.info("=========================================:"+ JsonUtil.encode(projectList));
            List<String> missList = permissionService.selectList("2",roleid);
            request.setAttribute("roles",missList);
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
       Map result=new HashMap();
       try {
           //getDays
           Worker worker=(Worker) session.getAttribute("worker");
           String creatordataid= worker.getDataid();//创建人ID
           String creator=worker.getName();//创建人
           project.setCreatordataid(creatordataid);
           project.setCreator(creator);
           String[] memberIdName=project.getMember().split("[+]");
           String[] meberIds=memberIdName[0].split(",");
           String[] meberNames=memberIdName[1].split(",");
           List<WorkerRelProject> mapList=new ArrayList<>();
           for (int i = 0; i < meberIds.length; i++) {
               WorkerRelProject workerRelProject=new WorkerRelProject();
               workerRelProject.setWorkerdataid(meberIds[i]);
               workerRelProject.setWorkername(meberNames[i]);
               mapList.add(workerRelProject);
           }
           projectService.insert(project,mapList);
           result.put("success",true);
       }catch (Exception e){
           result.put("success",false);
       }
logger.info("=================="+result);
        return result;
    }
    //根据部门查询人员
    @RequestMapping(value = "/selectUserListByDeptId")
    public @ResponseBody Object selectUserListByDeptId(@RequestBody Map deptMap){

        WorkerCriteria workerCriteria=new WorkerCriteria();
        String departmentdataid =deptMap.get("province_ids").toString();

        workerCriteria.setDepartmentdataid(departmentdataid);
        Map resultMap=new HashMap();
        try {
            //查询员工
            List<Worker> workerList=  workerService.selectList(workerCriteria);
            resultMap.put("workerList",workerList);
            resultMap.put("success",true);
        }catch (Exception e){
            resultMap.put("success",false);
        }
        return resultMap;
    }

    //根据部门列表查询人员
    @RequestMapping(value = "/selectUserList")
    public @ResponseBody Object selectUserList(@RequestBody Map deptMap){
        WorkerCriteria workerCriteria=new WorkerCriteria();
        String departmentdataid =deptMap.get("province_ids").toString();
        String[] departmentdataidList= departmentdataid.split(",");
        List list=new ArrayList();
        for (int i = 0; i < departmentdataidList.length; i++) {
            list.add(departmentdataidList[i]);
        }
        workerCriteria.setDepartmentdataidList(list);
      Map resultMap=new HashMap();
       try {
           //查询员工
           List<Worker> workerList=  workerService.selectList(workerCriteria);
           resultMap.put("workerList",workerList);
           resultMap.put("success",true);
       }catch (Exception e){
           resultMap.put("success",false);
       }
        return resultMap;
    }


    //查询项目进度详情
    @RequestMapping(value = "/projectDetail")
    public  String projectDetail(HttpServletRequest request,String name){
        try {
            ProjectCriteria projectCriteria=new ProjectCriteria();
            List<Project> projectList= projectService.selectList(projectCriteria);
            request.setAttribute("projectList",projectList);//项目
            String projectdataid="";
            name=(name==null?"":name);
            if (projectList.size()>1){
                if (name.equals("")||name==null){
                    projectdataid=  projectList.get(0).getDataid();//项目Id
                }else{
                    projectdataid=name;
                }
            }
            WorkdataCriteria workdataCriteria=new WorkdataCriteria();
            workdataCriteria.setProjectdataid(projectdataid);
            List<Workdata> workdataList= workDataService.queryList(workdataCriteria);
            request.setAttribute("workdataList",workdataList);

            request.setAttribute("selectId",projectdataid);
        }catch (Exception e){

        }
        return "project/project_progress_list";
    }

    //查看项目详情
    @RequestMapping(value = "/selectProjectDeatil")
    public String selectProjectDeatil(HttpServletRequest request,String projectId){
        try {
            ProjectCriteria projectCriteria=new ProjectCriteria();
            projectCriteria.setDataid(projectId);
            List<Project> projectList= projectService.selectList(projectCriteria);
            logger.info("=========================================:"+ projectList.size());
            Project project=new Project();
            if (projectList.size()>=1){
                project=projectList.get(0);
            }
            request.setAttribute("project",project);/*
            modelAndView.addObject("projectList",projectList);*/
        }catch (Exception e){
            e.printStackTrace();
        }
        return "project/project_detail";
    }

    @RequestMapping(value = "deleteProject")
    public @ResponseBody Object deleteProject( @RequestBody Map map,HttpSession session){
        Map resultMap=new HashMap();
        try {
            Project project=new Project();
            project.setDataid(map.get("contentId").toString());
            project.setState("5");
            Worker worker=(Worker) session.getAttribute("worker");
            String creatordataid= worker.getDataid();//创建人ID
            String creator=worker.getName();//创建人
            project.setModify(creator);
            project.setModifydataid(creatordataid);
            //逻辑删除
             projectService.update(project);
            resultMap.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            resultMap.put("success",false);
        }
        return resultMap;
    }
}
