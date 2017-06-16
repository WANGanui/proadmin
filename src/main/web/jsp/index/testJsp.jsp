<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<input type="hidden" id="add"  value="add"/>
<input type="hidden" id="delete"  value=""/>
<input type="hidden" id="update"  value="update"/>


<span class="add" style="display: none"> <input type="button"  value="添加" /> </span>
<span class="update" style="display: none"> <input type="button"  value="修改" /> </span>
<span class="delete" style="display: none"> <input type="button"  value="删除" /> </span>
<script type="text/javascript" src="<%=basePath%>js/jquery1.11.3.min.js"></script>
<script type="text/javascript" src="<%=basePath%>jsp/role.js"></script>
</body>
</html>
