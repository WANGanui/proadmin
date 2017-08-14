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
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

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
    MissionService missionService;
    @Autowired
    PermissionService permissionService;
    //查询项目列表
    @RequestMapping(value = "/projectList")
    public String selectProject(HttpServletRequest request,String roleid){
        try {
            ProjectCriteria projectCriteria=new ProjectCriteria();
           /* List<String> list=new ArrayList<>();
            list.add("4");
            list.add("3");
            list.add("2");
            list.add("1"); list.add("0");
            projectCriteria.setStateList(list);*/
            projectCriteria.setIsdelete("0");
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
           project.setAuditprogress("0");
           project.setIsdelete("0");
           project.setState("0");
           String auditorIds= project.getAuditorid();//审核人
           String[] auditorId=auditorIds.split(",");
           List<ProjectAudit> projectAudits=new ArrayList<>();
           for (int i = 0; i < auditorId.length; i++) {
               ProjectAudit projectAudit=new ProjectAudit();
               projectAudit.setAuditorid(auditorId[i]);
               projectAudit.setAuditstate("0");
               projectAudit.setOrderid(i);
               projectAudits.add(projectAudit);
           }
           String departmentId=project.getDepartmentid();//参与部门
           String[] departmentIds=departmentId.split(",");
           List<ProjectRelDepartment> projectRelDepartments=new ArrayList<>();
           for (int i = 0; i < departmentIds.length; i++) {
               ProjectRelDepartment projectRelDepartment=new ProjectRelDepartment();
               projectRelDepartment.setDepartmentid(departmentIds[i]);
               projectRelDepartments.add(projectRelDepartment);
           }
           projectService.insert(project,projectAudits,projectRelDepartments);
           result.put("success",true);
       }catch (Exception e){
           e.printStackTrace();
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
    public  String projectDetail(HttpServletRequest request,HttpSession session,String name){
        try {
            ProjectCriteria projectCriteria=new ProjectCriteria();
            List<Project> projectList= projectService.selectList(projectCriteria);
            request.setAttribute("projectList",projectList);//项目
            String projectdataid="";
            name=(name==null?"":name);
            List<Mission> missions=null;
            if (projectList.size()>=1){
                if (name.equals("")||name==null){
                    projectdataid= projectList.get(0).getDataid();//项目Id
                }else{
                    projectdataid=name;
                }

                MissionCriteria example=new MissionCriteria();
                example.setProdataid(projectdataid);
                missions = missionService.selectList(example);

            }
            request.setAttribute("list",missions);

            request.setAttribute("selectId",projectdataid);
        }catch (Exception e){
            e.printStackTrace();
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
            request.setAttribute("project",project);
            List<Map> list= projectService.selectByExample(projectId);
            request.setAttribute("projectAudits",list);
            /*modelAndView.addObject("projectList",projectList);*/
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
            project.setIsdelete("1");
            project.setDeletestate("0");
            project.setRemark(map.get("remake").toString());
            Worker worker=(Worker) session.getAttribute("worker");
            String creatordataid= worker.getDataid();//创建人ID
            String creator=worker.getName();//创建人
            project.setModify(creator);
            project.setModifydataid(creatordataid);
            //逻辑删除
             projectService.update(project);
             projectService.copy(map.get("contentId").toString());//复制审核表数据到删除审核表
            resultMap.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            resultMap.put("success",false);
        }
        return resultMap;
    }

    @RequestMapping(value = "/selectProjectAudit")
    public String selectProjectAudit(HttpSession session,HttpServletRequest request,String roleid){
        Worker worker=(Worker) session.getAttribute("worker");
        String auditId= worker.getDataid();//创建人ID
        try {
            List<String> missList = permissionService.selectList("2",roleid);
            request.setAttribute("roles",missList);
            request.setAttribute("projectList",projectService.selectProjectAudit(auditId));
        }catch (Exception e){
            e.printStackTrace();
        }
        return "project/project_audit_list";
    }


    @RequestMapping(value = "/updateProjectAuditState")
    public @ResponseBody Object updateProjectAuditState(@RequestBody Map map,HttpSession session){
        Map resultMap=new HashMap();
        try {
            int auditInt =0;
            if ("1".equals(map.get("isdelete").toString())){
                ProjectAuditDel projectAuditDel=new ProjectAuditDel();
                projectAuditDel.setRemark(map.get("remark").toString());
                projectAuditDel.setAuditstate(map.get("auditState").toString());
                projectAuditDel.setId(Integer.parseInt(map.get("auditId").toString()));
                projectService.updateByPrimaryKeySelective(projectAuditDel);
                Map mapInt = new HashMap();
                mapInt.put("auditstate", "0");
                mapInt.put("projectid", map.get("projectId").toString());
                auditInt= projectService.selectAuditDelInt(mapInt);
            }else {
                ProjectAudit projectAudit = new ProjectAudit();
                projectAudit.setRemark(map.get("remark").toString());
                projectAudit.setAuditstate(map.get("auditState").toString());
                projectAudit.setId(Integer.parseInt(map.get("auditId").toString()));
                projectService.updateByPrimaryKeySelective(projectAudit);
                Map mapInt = new HashMap();
                mapInt.put("auditstate", "0");
                mapInt.put("projectid", map.get("projectId").toString());
                auditInt= projectService.selectAuditInt(mapInt);
            }
            Project project=new Project();
            if (auditInt>0){

                if ("1".equals(map.get("isdelete").toString())) {
                    project.setDeletestate("1");//删除中
                }else {
                    project.setState("2");
                }
            }

            if (auditInt==0){
                if ("1".equals(map.get("isdelete").toString())) {
                    project.setDeletestate("2");//不同意删除
                    project.setIsdelete("2");//已经删除
                }else {
                    project.setState("1");
                }

            }
            if ("2".equals(map.get("auditState").toString())){

                if ("1".equals(map.get("isdelete").toString())) {
                    project.setIsdelete("0");//不同意删除
                }else {
                    project.setState("3");
                }

            }
            project.setDataid(map.get("projectId").toString());

            Worker worker=(Worker) session.getAttribute("worker");
            String creatordataid= worker.getDataid();//创建人ID
            String creator=worker.getName();//创建人
            project.setModify(creator);
            project.setModifydataid(creatordataid);
            projectService.update(project);
            resultMap.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            resultMap.put("success",false);
        }
        return resultMap;
    }

    //查询废弃项目列表
    @RequestMapping(value = "/selectDeleteProject")
    public String selectDeleteProject(HttpServletRequest request,String roleid){
        try {
            ProjectCriteria projectCriteria=new ProjectCriteria();
            List<String> list=new ArrayList<>();
            list.add("1");
            list.add("2");
            projectCriteria.setIsdeleteList(list);
            List<Project> projectList= projectService.selectList(projectCriteria);
            logger.info("=========================================:"+ JsonUtil.encode(projectList));
            request.setAttribute("projectList",projectList);
        }catch (Exception e){
            e.printStackTrace();
        }
        return "project/project_delete_list";
    }


    @RequestMapping(value = "/addTadaTable")
    public @ResponseBody Object addTadaTable(){
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); // 日期格式
            Date date = dateFormat.parse("2017-01-01"); // 指定日期

            System.out.println(dateFormat.format(date));// 输出格式化后的日期

            Map map=null;
            for (int i = 1; i < 366; i++) {
                map=new HashMap();
                Date newDate = addDate(date, i); // 指定日期加上20天
                String date1= dateFormat.format(newDate);
                System.out.println(date1);
                map.put("dataTime",date1);
                projectService.insertDataTable(map);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return  null;
    }
    public static Date addDate(Date date,long day) throws ParseException {
        long time = date.getTime(); // 得到指定日期的毫秒数
        day = day*24*60*60*1000; // 要加上的天数转换成毫秒数
        time+=day; // 相加得到新的毫秒数
        return new Date(time); // 将毫秒数转换成日期
    }

    @RequestMapping("/selectProjectFile")
    public ModelAndView selectMissionFile(String dataid){
        ModelAndView model = new ModelAndView();
        try {
            Project project = projectService.selectDetail(dataid);
            List<MissionFile> files = missionService.selectProjectFile(dataid);
            model.addObject("file",files);
            model.addObject("project",project);
            model.setViewName("project/project_upload");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/projectReport")
    public ModelAndView selectProjectReport(){
        ModelAndView model = new ModelAndView();
        try {
            List<Project> projectList = projectService.selectProjectReport(new ProjectCriteria());
            model.addObject("project",projectList);
            model.setViewName("project/project_weekreport");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/addProjectProgress")
    public ModelAndView projectProgressList(HttpSession session){
        ModelAndView model = new ModelAndView();
        Worker worker = (Worker)session.getAttribute("worker");
        try {
            List<ProjectWeekReport> projectWeekReportList = projectService.selectReportList(worker.getDataid());
            model.addObject("report",projectWeekReportList);
            model.setViewName("project/project_worker_report");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/addprojectreport")
    public ModelAndView toaddprojectreport(HttpSession session){
        ModelAndView model = new ModelAndView();
        Worker worker = (Worker)session.getAttribute("worker");
        try {
            List<Project> projectList = projectService.selectProjectListByworker(worker.getDataid());
            model.addObject("project",projectList);
            model.setViewName("project/add_project_report");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/addreport")
    public @ResponseBody Object addreport(@RequestBody ProjectWeekReport projectWeekReport){
        Map map = new HashMap();
        try {
            boolean bool = projectService.insertReport(null,projectWeekReport);
            map.put("success",bool);
        } catch (Exception e) {
            map.put("success",false);
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping("/toupdatereport")
    public ModelAndView toupdatereport(String dataid){
        ModelAndView model = new ModelAndView();
        try {
            ProjectWeekReport report = projectService.selectReportdetail(dataid);
            model.setViewName("project/edit_project_report");
            model.addObject("report",report);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/updatereport")
    public @ResponseBody Object updatereport(@RequestBody ProjectWeekReport projectWeekReport){
        Map map = new HashMap();
        try {
            boolean bool = projectService.updateReport(projectWeekReport);
            map.put("success",bool);
        } catch (Exception e) {
            map.put("success",false);
            e.printStackTrace();
        }
        return map;
    }
}
