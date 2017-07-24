package com.hrg.module.notice;

import com.hrg.enums.ErrorCode;
import com.hrg.global.ApiResult;
import com.hrg.model.Notice;
import com.hrg.model.NoticeRelWorker;
import com.hrg.model.Worker;
import com.hrg.service.NoticeService;
import com.hrg.service.PermissionService;
import com.hrg.util.JsonUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 82705 on 2017/6/20.
 */
@Controller
public class NoticeController {
    private static Logger logger = Logger.getLogger("NoticeController");

    @Autowired
    NoticeService noticeService;
    @Autowired
    PermissionService permissionService;

    @RequestMapping("/noticeList")
    public ModelAndView selectList(HttpSession session,String roleid){
        ModelAndView model = new ModelAndView();
        try {
            logger.info("==============开始查询公告列表=============");
            Worker worker = (Worker) session.getAttribute("worker");
           Map map=new HashMap();
           map.put("workerid",worker.getDataid());
            List<Map> noticeList = noticeService.selectNoticeWork(map);
            List<String> missList = permissionService.selectList("13",roleid);
            logger.info("==============查询公告列表成功==============");
            model.addObject("roles",missList);
            model.addObject("list",noticeList);
            model.setViewName("notice/notice_list");
        } catch (Exception e) {
            logger.info("=============查询公告列表失败，系统异常============");
            model.addObject(JsonUtil.encode(ApiResult.returnFail(ErrorCode.SYSTEM_EXCEPTION.getMessage(),ErrorCode.SYSTEM_EXCEPTION.getCode())));
            e.printStackTrace();
        }
        return model;
    }
    @RequestMapping("/noticeAdd")
    public String gotoaddnotice(){
        return "notice/notice_add";
    }

    @RequestMapping("/addNotice")
    public @ResponseBody Object addNotice(HttpSession session, @RequestBody Notice notice){
        Map map = new HashMap<>();
        try {
            Worker worker = (Worker) session.getAttribute("worker");
            notice.setWorkerdataid(worker.getDataid());
            notice.setWorker(worker.getName());
            notice.setDepartmentdataid(worker.getDepartmentdataid());
            notice.setDepartment(worker.getDepartment());
            noticeService.insert(notice);
            map.put("success",true);
        } catch (Exception e) {
            map.put("success",false);
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping("/toeditNotice")
    public ModelAndView toeditNotice(String dataid){
        ModelAndView model = new ModelAndView();
        try {
            Notice notice = noticeService.selectDetail(dataid);
            model.addObject("notice",notice);
            model.setViewName("notice/notice_detail");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return model;
    }

    @RequestMapping("/deleteNotice")
    public @ResponseBody Object delete(@RequestBody Map remap){
        Map map = new HashMap();
        try {
            String dataid = remap.get("dataid").toString();
           boolean bool =  noticeService.delete(dataid);
           if (bool)
               map.put("success",true);
           else
               map.put("success",false);
        } catch (Exception e) {
            map.put("success",false);
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping("/updateNotice")
    public @ResponseBody Object delete(HttpSession session, @RequestBody Notice notice){
        Map map = new HashMap<>();
        try {
            noticeService.update(notice);
            map.put("success",true);
        } catch (Exception e) {
            map.put("success",false);
            e.printStackTrace();
        }
        return map;
    }

    @RequestMapping(value = "/updateStatusNoticeRelWorker")
    public @ResponseBody Object updateStatusNoticeRelWorker(@RequestBody Map map){
        Map result = new HashMap<>();

        try {
            NoticeRelWorker noticeRelWorker=new NoticeRelWorker();
            noticeRelWorker.setDataid(map.get("dataid").toString());
            noticeRelWorker.setIsread(map.get("status").toString());
            noticeService.updateStatusNoticeRelWorker(noticeRelWorker);
            result.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            result.put("success",false);
        }
        return result;
    }
}
