<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<link rel="stylesheet" href="../css/top01.css">
<script language="JavaScript" src="../js/jquery.js">
</script>
<style>
a{
text-decoration:none;
color:#fff;
}
</style>
<body>
<div class="top01-bg">
<ul>
    <li class="b01 active"></li>
    <li class="b02"></li>
    <li class="b07"></li>
</ul>

</div>
<ul class="ul-ti">
    <a href="../adm/user/index.do" target="_parent"><li class="ul-tietle">首页</li></a>
    <li class="ul-tietle">${user_info.admUserName}</li>
    <a href="../adm/user/loginout.do" target="_parent"><li class="ul-tietle">退出</li></a>
</ul>
</body>
</body>
