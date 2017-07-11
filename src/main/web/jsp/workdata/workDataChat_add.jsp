<!--_meta 作为公共模版分离出去-->
<%@ page language="java" import="java.util.*"	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!--_meta 作为公共模版分离出去-->
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="stylesheet" href="<%=basePath%>/css/layui.css"  media="all">
    <!--[if lt IE 9]>
    <script type="text/javascript" src="<%=basePath%>lib/html5.js"></script>
    <script type="text/javascript" src="<%=basePath%>lib/respond.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>lib/PIE_IE678.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath%>kindeditor/kindeditor.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath%>kindeditor/lang/zh_CN.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>lib/Hui-iconfont/1.0.7/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>lib/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/h-ui.admin/css/style.css" />
    <script type="text/javascript" charset="utf-8" src="<%=basePath%>kindeditor/kindeditor.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath%>kindeditor/lang/zh_CN.js"></script>
    <!--[if IE 6]>
    <script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath%>kindeditor/kindeditor.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=basePath%>kindeditor/lang/zh_CN.js"></script>

    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <!--/meta 作为公共模版分离出去-->

    <title>日志评论</title>
</head>
<body>
<div class="page-container">
    <form class="form form-horizontal" action="addCaseContent.do" method="post"  id="form-article-add" enctype="multipart/form-data">
        <div class="row cl">


            <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>工作内容：</label>
            <div class="formControls col-xs-8 col-sm-9">
            <textarea rows="4" cols="120" readonly>${workData.workcontext}</textarea>
                <input type="hidden" id="workDataId" value="${workData.dataid}"/>
            </div>
            </div>
            <c:forEach var="chats" items="${chat}">
                    <div class="row cl">
                        <label class="form-label col-xs-4 col-sm-2"> ${chats.chatname}：</label>
                        <div class="formControls col-xs-8 col-sm-9">
                            <textarea rows="4" cols="120" readonly> ${chats.context}</textarea><%--
                            <input type="text"  class="input-text"  readonly value="${chats.context}" placeholder="" id="contentTitle" name="contentTitle">--%>
                        </div>
                    </div>
            </c:forEach>
        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span> 回复：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <textarea rows="4" cols="120" id="context"></textarea><%--
                            <input type="text"  class="input-text"  readonly value="${chats.context}" placeholder="" id="contentTitle" name="contentTitle">--%>
            </div>
        </div>

        <div id="but" class="row cl">
            <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
                <button onClick="article_save_submit()"  class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存并提交</button>
                <button onClick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
            </div>
        </div>
    </form>
</div>
</div>

<!--_footer 作为公共模版分离出去-->
<%--<script type="text/javascript" src="js/previewImge.js"></script>--%>
<script type="text/javascript" src="<%=basePath%>js/jquery1.11.3.min.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/jquery.validation/1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/jquery.validation/1.14.0/messages_zh.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="<%=basePath%>static/h-ui.admin/js/H-ui.admin.js"></script>
<script src="<%=basePath%>laydate/laydate.js"></script>
<!--/_footer /作为公共模版分离出去-->
<%--日期插件--%>
<script>
    laydate({
        elem: '#startTime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
        event: 'focus' //响应事件。如果没有传入event，则按照默认的click
    });
    laydate({
        elem: '#endTime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
        event: 'focus' //响应事件。如果没有传入event，则按照默认的click
    });


    function article_save_submit() {
         var workDataId= $("#workDataId").val();
         var context=$("#context").val();
         if (context.length==0){
             layer.msg('请输入回复内容，无回复请点击取消', {time: 2000, icon: 5});
             return false;
         }
        var dataJson = {
            workDataId:workDataId,//项目ID
            context:context//回复内容
        };
        $.ajax( {
            url : '<%=basePath%>replyCommentsAdd',
            type : 'post',
            contentType : 'application/json;charset=utf-8',
            dataType : 'json',
            data : JSON.stringify(dataJson),
            success : function(data) {

                if (data.success) {
                    layer.msg('回复成功' ,{time: 2000, icon:6});
                    window.location.reload();
                } else {
                    layer.msg('回复失败' ,{time: 2000, icon:5});

                }
            }
        });
    }
</script>
</body>
</html>