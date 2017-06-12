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
</head>

<body>
<div class="dialog-body-center">
    <form>
        <ul class="double-td">
            <li><span class="title">用户名</span><input name="userName" class="input-sm"></li>
            <li><span class="title">密码</span><input name="pwd" class="input-sm"></li>
            <li><span class="title">手机号码</span><input name="phoneNo" class="input-sm"/></li>
            <li><span class="title">状态</span><select name="yhztFordic" class="form-control" forDic="CZLX"></select></li>
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

    console.warn("正式环境需要注入JSON对象.当前模拟注入的数据为:",jsonData);

    var WebPro_dialogPage = WebPro_dialogPage(window.parent,${data});
</script>
</html>
