package com.hrg.module.notice;

import com.hrg.enums.ErrorCode;
import com.hrg.global.ApiResult;
import com.hrg.model.Notice;
import com.hrg.model.NoticeCriteria;
import com.hrg.service.NoticeService;
import com.hrg.util.JsonUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * Created by 82705 on 2017/6/20.
 */
@Controller
public class NoticeController {
    private static Logger logger = Logger.getLogger("NoticeController");

    @Autowired
    NoticeService noticeService;

    @RequestMapping("/noticeList")
    public ModelAndView selectList(NoticeCriteria example){
        ModelAndView model = new ModelAndView();
        try {
            logger.info("==============开始查询公告列表=============");
            logger.info("==============入参【"+ JsonUtil.encode(example)+"】==============");
            List<Notice> noticeList = noticeService.selectList(example);
            logger.info("==============查询公告列表成功==============");
            model.addObject("list",noticeList);
            model.setViewName("notice/notice_list");
        } catch (Exception e) {
            logger.info("=============查询公告列表失败，系统异常============");
            model.addObject(JsonUtil.encode(ApiResult.returnFail(ErrorCode.SYSTEM_EXCEPTION.getMessage(),ErrorCode.SYSTEM_EXCEPTION.getCode())));
            e.printStackTrace();
        }
        return model;
    }
}
