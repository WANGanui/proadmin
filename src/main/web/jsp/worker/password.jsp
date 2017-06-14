<%--
  Created by IntelliJ IDEA.
  User: 82705
  Date: 2017/6/12
  Time: 15:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="<%=basePath%>css/public.css" />
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.css" />
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap-theme.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/wangEditor.min.css">

    <link href="<%=basePath%>css/font-awesome.min.css" rel="stylesheet" />
    <link href="<%=basePath%>css/webpro.dialoginfo.css" rel="stylesheet" />

    <script type="text/javascript" src="<%=basePath%>js/jquery1.11.3.min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/wangEditor.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/lyz.calendar.min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery.validate.js"></script>

    <script type="text/javascript" src="<%=basePath%>js/mock-min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/webpro.debug.js" ></script>

    <style>
        /**可以自定义富文本高度**/
        .textareaDiv textarea{height: 225px;	}
    </style>
    <%--<script>
        var webPro=window.parent.webpro;
        var url = "<%=basePath%>worker/editPass";
        $("#okBtn").click(function () {
            var pwd = $(".input-sm name").val();
            var newpwd = $(".input-sm password").val();
            var userID = ${data}.worker.dataid;
            $.ajax({
                type:"POST",
                url:url,
                data:{"userID":userID,"password":pwd,"newPassword":newpwd},
                dataType:"json",
                success:function (data) {
                    if (data.status=="200"){
                        msg.alertInfo("请求成功！");
                        webPro.mainDialog.closeDialogDiv();
                    }else{
                        msg.alertErr(data.msg+",错误代码："+data.status);
                    }
                }
            });
        });
    </script>--%>
</head>

<body>
<div class="dialog-body-center">
    <form>
        <ul class="double-td">
            <li><span class="title">原密码</span><input name="password" type="password" class="input-sm name"></li>
            <li><span class="title">新密码</span><input name="newPassword" type="password" class="input-sm password"></li>
            <li><span class="title">确认密码</span><input name="newPassword1" type="password" class="input-sm"/></li>
        </ul>
    </form>
</div>
<div class="bottom-bar">
    <button id="closeBtn" class="button-rounded button-royal">关闭</button>
    <button id="okBtn" class="button-rounded button-royal">确定</button>
</div>
</body>
<script type="text/javascript" src="<%=basePath%>js/webpro.dialog.js"></script>
<script type="text/javascript">
    var url = "<%=basePath%>worker/editPass";
    console.warn("JSON对象.当前注入的数据为:",${data});
    var WebPro_dialogPage = WebPro_dialogPage(window.parent,${data},url);
</script>
</html>
