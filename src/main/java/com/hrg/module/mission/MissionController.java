package com.hrg.module.mission;

import com.hrg.enums.ErrorCode;
import com.hrg.exception.ValidatorException;
import com.hrg.global.ApiResult;
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
import java.util.ArrayList;
import java.util.HashMap;
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
    @Autowired
    DepartmentService departmentService;
    @Autowired
    WorkerService workerService;
    @Autowired
    PermissionService permissionService;

    @RequestMapping("/missionList")
    public ModelAndView selectList(HttpSession session, MissionCriteria example,String roleid){
        Worker worker = (Worker) session.getAttribute("worker");
        example.setAuditorid(worker.getDataid());
        ModelAndView model = new ModelAndView();
        try {
            logger.info("============开始任务列表查询=============");
            logger.info("============入参【"+ JsonUtil.encode(example)+"】=============");
            List list = new ArrayList();
            list.add("0");
            list.add("1");
            example.setStateList(list);
            List<Mission> missions = missionService.selectList(example,worker);
            List<String> missList = permissionService.selectList("6",roleid);
            logger.info("============任务列表查询成功=============");
            model.addObject("roles",missList);
            model.addObject("list",missions);
            model.setViewName("mission/mission_list");
        } catch (Exception e) {
            logger.info("============任务列表查询失败，系统异常=============");
            model.addObject(JsonUtil.encode(ApiResult.returnFail(ErrorCode.SYSTEM_EXCEPTION.getMessage(),ErrorCode.SYSTEM_EXCEPTION.getCode())));
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/missionend")
    public ModelAndView selectListend(HttpSession session, MissionCriteria example,String roleid){
        Worker worker = (Worker) session.getAttribute("worker");
        example.setAuditorid(worker.getDataid());
        ModelAndView model = new ModelAndView();
        try {
            logger.info("============开始任务列表查询=============");
            logger.info("============入参【"+ JsonUtil.encode(example)+"】=============");
            example.setMissionstate("0");
            example.setState("2");
            List<Mission> missions = missionService.selectList(example);
            List<String> missList = permissionService.selectList("22",roleid);
            logger.info("============任务列表查询成功=============");
            model.addObject("roles",missList);
            model.addObject("list",missions);
            model.setViewName("mission/mission_list");
        } catch (Exception e) {
            logger.info("============任务列表查询失败，系统异常=============");
            model.addObject(JsonUtil.encode(ApiResult.returnFail(ErrorCode.SYSTEM_EXCEPTION.getMessage(),ErrorCode.SYSTEM_EXCEPTION.getCode())));
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/missionrefuse")
    public ModelAndView selectListrefuse(HttpSession session, MissionCriteria example,String roleid){
        Worker worker = (Worker) session.getAttribute("worker");
        example.setAuditorid(worker.getDataid());
        ModelAndView model = new ModelAndView();
        try {
            logger.info("============开始任务列表查询=============");
            logger.info("============入参【"+ JsonUtil.encode(example)+"】=============");
            example.setMissionstate("1");
            example.setState("0");
            List<Mission> missions = missionService.selectList(example);
            List<String> missList = permissionService.selectList("23",roleid);
            logger.info("============任务列表查询成功=============");
            model.addObject("roles",missList);
            model.addObject("list",missions);
            model.setViewName("mission/mission_list");
        } catch (Exception e) {
            logger.info("============任务列表查询失败，系统异常=============");
            model.addObject(JsonUtil.encode(ApiResult.returnFail(ErrorCode.SYSTEM_EXCEPTION.getMessage(),ErrorCode.SYSTEM_EXCEPTION.getCode())));
            e.printStackTrace();
        }
        return model;
    }

    //查询待审核任务
    @RequestMapping("/missionCheck")
    public ModelAndView missionCheck(HttpServletRequest request, MissionCriteria example,String roleid,HttpSession session){
        ModelAndView model = new ModelAndView();
        try {
            logger.info("============开始任务列表查询=============");
          example.setMissionstate("2");
            Worker worker=(Worker) session.getAttribute("worker");
            String creatordataid= worker.getDataid();//创建人ID
          example.setAuditorid(creatordataid);

            logger.info("============入参【"+ JsonUtil.encode(example)+"】=============");
            List<Mission> missions = missionService.selectList(example);
logger.info("========================返回结果："+JsonUtil.encode(missions));
            List<String> missList = permissionService.selectList("19",roleid);
            logger.info("============任务列表查询成功=============");
            model.addObject("roles",missList);
            model.addObject("list",missions);
            model.setViewName("mission/mission_audit_list");
        } catch (Exception e) {
            logger.info("============任务列表查询失败，系统异常=============");
            model.addObject(JsonUtil.encode(ApiResult.returnFail(ErrorCode.SYSTEM_EXCEPTION.getMessage(),ErrorCode.SYSTEM_EXCEPTION.getCode())));
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping(value = "/updateState")
    public @ResponseBody Object updateState(@RequestBody Map map){
       Map resultMap=new HashMap();
         try {

             Mission mission=new Mission();
             mission.setDataid(map.get("dataId").toString());
             mission.setMissionstate(map.get("missionState").toString());
             mission.setRemark(map.get("remark").toString());
             if ("0".equals(map.get("mes").toString())){
                 mission.setState("1");
             }
             missionService.updateState(mission);
             resultMap.put("success",true);
         }catch (Exception e){
            e.printStackTrace();
            resultMap.put("success",false);
         }
        return resultMap;
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
    public ModelAndView gotoAdd(HttpSession session){
        Worker worker = (Worker)session.getAttribute("worker");
        ModelAndView model = new ModelAndView();
        try {
            List<Project> list = projectService.selectByWorker(worker.getDataid());
            model.addObject("list",list);
            List<Department> departmentList= departmentService.selectList(new DepartmentCriteria());
            List<Worker> list1 = workerService.selectList(new WorkerCriteria());
            model.addObject("partment",departmentList);
            model.addObject("workers",list1);
            model.setViewName("mission/mission_add");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/missionListByProject")
    public @ResponseBody Object selectlistBypro(@RequestBody Map deptMap,HttpSession session){
        Worker worker = (Worker)session.getAttribute("worker");
        MissionCriteria example = new MissionCriteria();
        example.setProdataid(deptMap.get("dataid").toString());
        Map map = new HashMap();
        try {
            List<Mission> missionList = missionService.selectList(example,worker);
            map.put("missionList",missionList);
            map.put("success",true);
        } catch (Exception e) {
            map.put("success",false);
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping("/selectMissionDd")
    public @ResponseBody Object selectMissionDd(@RequestBody Map deptMap){
        MissionCriteria example = new MissionCriteria();
        String missionid =deptMap.get("province_ids").toString();
        String[] missionidList= missionid.split(",");
        List list=new ArrayList();
        for (int i = 0; i < missionidList.length; i++) {
            list.add(missionidList[i]);
        }
        Map map = new HashMap();
        example.setDataidList(list);
        try {
            List<Mission> missionList = missionService.selectList(example);
            String context = "";
            for (Mission mission : missionList){
                context += mission.getContext()+"。";
            }
            map.put("context",context);
            map.put("missionList",missionList);
            map.put("success",true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping("/addMission")
    public @ResponseBody Object addmission(HttpSession session,@RequestBody Mission mission){
        Map result=new HashMap();
        try {
            Worker worker = (Worker) session.getAttribute("worker");
            mission.setCreator(worker.getName());
            mission.setCreatordataid(worker.getDataid());
            String members = mission.getMember();
            String[] memberIdName=members.split("[+]");
            String[] meberIds=null;
            String[] meberNames=null;
            if (memberIdName.length>=1){
                meberIds =memberIdName[0].split(",");
            }
            if (memberIdName.length>=2){
                meberNames =memberIdName[1].split(",");
            }
            List<Worker> workerList = new ArrayList<>();
            if (meberIds!=null){
                for (int i = 0;i < meberIds.length; i++){
                    Worker relMission = new Worker();
                    relMission.setDataid(meberIds[i]);
                    relMission.setName(meberNames[i]);
                    workerList.add(relMission);
                }
            }
            missionService.insert(mission,workerList);
            result.put("success",true);
        } catch (Exception e) {
            result.put("success",false);
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/toupdatemission")
    public ModelAndView toupdatemission(String dataid){
        ModelAndView model = new ModelAndView();
        Map map = new HashMap();
        try {
            List<Department> departmentList= departmentService.selectList(new DepartmentCriteria());
            map = missionService.selectDetailById(dataid);
            map.put("partment",departmentList);
            model.addObject("map",map);
            model.setViewName("mission/mission_edit");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/missionDetail")
    public ModelAndView selectMissionDetail(String dataid){
        ModelAndView model = new ModelAndView();
        Map map = new HashMap();
        try {
            map = missionService.selectDetailById(dataid);
            model.addObject("map",map);
            model.setViewName("mission/mission_detail");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }


    @RequestMapping("/deleteMission")
    public @ResponseBody Object deleteMission(@RequestBody  Map remap){
        Map map = new HashMap();
        boolean bool;
        try {
            String dataid = remap.get("dataid").toString();
            bool = missionService.deleteMission(dataid);
            if (bool){
                map.put("success",true);
            }else {
                map.put("success",false);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping("/updateMission")
    public @ResponseBody Object updateMission(HttpSession session,@RequestBody Mission mission){
        Map result=new HashMap();
        try {
            Worker worker = (Worker) session.getAttribute("worker");
            mission.setModify(worker.getName());
            mission.setModifydataid(worker.getDataid());
            String members = mission.getMember();
            String[] memberIdName=members.split("[+]");
            String[] meberIds=null;
            String[] meberNames=null;
            if (memberIdName.length>=1){
                meberIds =memberIdName[0].split(",");
            }
            if (memberIdName.length>=2){
                meberNames =memberIdName[1].split(",");
            }
            List<Worker> workerList = new ArrayList<>();
            if (meberIds!=null){
                for (int i = 0;i < meberIds.length; i++){
                    Worker relMission = new Worker();
                    relMission.setDataid(meberIds[i]);
                    relMission.setName(meberNames[i]);
                    workerList.add(relMission);
                }
            }
            missionService.update(mission,workerList);
            result.put("success",true);
        } catch (Exception e) {
            result.put("success",false);
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/selectPartmentBypro")
    public @ResponseBody Object selectPartmentBypro(String dataid){
        Map map = new HashMap();
        try {
            List<Department> departmentList = departmentService.selectPartmentBypro(dataid);
            map.put("partmentList",departmentList);
            map.put("success",true);
        } catch (Exception e) {
            map.put("success",false);
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping("/missionjindu")
    public ModelAndView missionjindu(String dataid){
        ModelAndView model = new ModelAndView();
        Map map = new HashMap();
        try {
            map = missionService.selectMissionJindu(dataid);
            model.addObject("map",map);
            model.setViewName("mission/mission_jindu");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }
}
