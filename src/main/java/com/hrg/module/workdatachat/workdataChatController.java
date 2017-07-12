package com.hrg.module.workdatachat;

import com.hrg.model.WorkdataChat;
import com.hrg.model.WorkdataChatCriteria;
import com.hrg.model.Worker;
import com.hrg.service.WorkDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2017/7/11.
 */
@Controller
public class workdataChatController {

    @Autowired
    WorkDataService workDataService;

    @RequestMapping(value = "/workDataChatHtm")
    public String workDataChatHtm(HttpServletRequest request,String dataId,HttpSession session){
        //request.setAttribute("dataId",dataId);
        try {
            Worker worker=(Worker) session.getAttribute("worker");
           // WorkdataChat record=new WorkdataChat();
            Map record= new HashMap();
            record.put("isread","1");
            record.put("chatid",worker.getDataid());
            record.put("workdataid",dataId);
            /* WorkdataChatCriteria example=new WorkdataChatCriteria();
            example.setChatid(worker.getDataid());
            example.setWorkdataid(dataId);*/
            workDataService.updateByExampleSelective(record);
            WorkdataChatCriteria workdataChatCriteria=new WorkdataChatCriteria();
            workdataChatCriteria.setWorkdataid(dataId);
            workdataChatCriteria.setOrderByClause("dataid ASC");
           request.setAttribute("chat", workDataService.selectByExample(workdataChatCriteria));
           request.setAttribute("workData",workDataService.selectDetail(dataId));
        }catch (Exception e){
            e.printStackTrace();
        }
        return "workdata/workDataChat_add";
    }

    @RequestMapping(value = "/replyCommentsAdd")
    public @ResponseBody Object replyCommentsAdd(@RequestBody Map map, HttpSession session){
       Map result =new HashMap();
        try {
            Worker worker=(Worker) session.getAttribute("worker");
            WorkdataChat workdataChat=new WorkdataChat();
            workdataChat.setChatid(worker.getDataid());//评论人ID
            workdataChat.setChatname(worker.getName());//评论人姓名
            workdataChat.setContext(map.get("context").toString());//回复内容
            workdataChat.setWorkdataid(map.get("workDataId").toString());//日志ID
            workdataChat.setIsread("0");//添加时未读状态
            workDataService.insert(workdataChat);
            result.put("success",true);
        }catch (Exception e){
            e.printStackTrace();
            result.put("success",false);
        }

        return result;
    }
}
