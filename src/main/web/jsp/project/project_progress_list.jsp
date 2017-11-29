<!--_meta 作为公共模版分离出去-->
<%@ page language="java" import="java.util.*"	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="<%=basePath%>lib/html5.js"></script>
    <script type="text/javascript" src="<%=basePath%>lib/respond.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>lib/PIE_IE678.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>lib/Hui-iconfont/1.0.7/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>lib/icheck/icheck.css" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/h-ui.admin/css/style.css" />
    <!--[if IE 6]>
    <script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->

    <title>项目进度详情</title>
    <style>
        textarea{
            border:0;
            background-color:transparent;
            /*scrollbar-arrow-color:yellow;
            scrollbar-base-color:lightsalmon;
            overflow: hidden;*/
            color: #666464;
            height: auto;
        }
    </style>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 项目管理 <span class="c-gray en">&gt;</span> 项目进度详情 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <form id="form" action="projectDetail" method="post">

        <div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><select onchange="projectProgress()" id="dataId" name="name" class="select" style="width: 150px;"><c:forEach items="${projectList}" var="project"><option value="${project.dataid}" <c:if test="${selectId==project.dataid}">selected</c:if>>${project.name}</option></c:forEach></select></span> </div>
    </form>
    <div class="mt-20">
        <table class="table table-border table-bordered table-bg table-hover table-sort" id="table1">
            <thead>
            <tr class="text-c">
                <th width="40">序号</th>
                <th width="60">任务名称</th>
                <th width="80">开始时间</th>
                <th width="80">计划结束时间</th>
                <th  width="60">项目名称</th>
                <th width="60">进度</th>
                <th width="60">任务比重</th>
                <th width="60">创建人</th>
                <th width="60">审核人</th>
                <th width="60">责任人</th>
                <th width="60">类型</th>
                <th width="60">项目阶段</th>
                <th width="70">流程状态</th>
                <th width="70">任务状态</th>
                <th width="100">操作</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach items="${list}" var="mission1" varStatus="missionIndex1">
                <tr class="text-c" <c:if test="${mission1.finishtime>mission1.endtime}"> style="background-color: red" </c:if>>

                    <td>${missionIndex1.index+1}</td>
                    <td onclick="picture_query('任务详情','<%=basePath%>missionDetail?dataid=${mission1.dataid}')" style="text-decoration:underline">${mission1.name}</td>

                    <td class="td-time"><fmt:formatDate value="${mission1.starttime}" pattern="yyyy-MM-dd" /></td>
                    <td class="td-time"><fmt:formatDate value="${mission1.endtime}" pattern="yyyy-MM-dd" /></td>
                    <td>${mission1.proname}</td>
                    <td>${mission1.percentage}</td>
                    <td>${mission1.proportion}级</td>
                    <td>${mission1.creator}</td>
                    <td>${mission1.auditorname}</td>
                    <td>${mission1.headername}</td>
                    <td class="td-status"><c:if test="${mission1.type==0}">
                        <span class="label label-success radius">	项目任务 </span>
                    </c:if>
                        <c:if test="${mission1.type==1}">
                            <span class="label label-success radius">个人任务</span>
                        </c:if>
                    </td>
                    <td class="td-status">
                        <span class="label label-success radius">${mission1.level}</span>
                    </td>
                    <td class="td-status"><c:if test="${mission1.state==0}">
                        <span class="label label-success radius" style="background-color: #00a0e9">	未开始 </span>
                    </c:if>
                        <c:if test="${mission1.state==1}">
                            <span class="label label-success radius" style="background-color: #13DAEC">进行中</span>
                        </c:if>
                        <c:if test="${mission1.state==2}">
                            <span class="label label-success radius">已完成</span>
                        </c:if>
                    </td>
                    <td class="td-status"><c:if test="${mission1.missionstate==0}">
                        <span class="label label-success radius">	已同意 </span>
                    </c:if>
                        <c:if test="${mission1.missionstate==1}">
                            <span class="label label-success radius" style="background-color: #985f0d">已拒绝</span>
                        </c:if>
                        <c:if test="${mission1.missionstate==2}">
                            <span class="label label-success radius" style="background-color: #00a0e9">待审核</span>
                        </c:if>
                    </td>
                    <td class="td-manage">
                      <%--  <a style="text-decoration:none" class="ml-5 delete" onClick="picture_del('${mission1.dataid}')" title="删除"><i class="Hui-iconfont" style="font-size: 20px" >&#xe6e2;</i></a>
                        <a style="text-decoration:none" class="ml-5 update" onClick="picture_query('编辑任务','<%=basePath%>/toupdatemission?dataid=${mission1.dataid}')" title="编辑"><i class="Hui-iconfont">&#xe60c;</i></a>
                      --%>  <a style="text-decoration:none" class="ml-5 update" onClick="picture_query('进度详情','<%=basePath%>/missionjindu?dataid=${mission1.dataid}')" title="进度详情"><i class="Hui-iconfont">&#xe667;</i></a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="static/h-ui/js/ZeroClipboard.js"></script>
<script type="text/javascript">
    $('.table-sort').dataTable({
        "aaSorting": [[ 0, "asc" ]],//默认第几个排序
        "bStateSave": false,//状态保存
        "aoColumnDefs": [
            //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
            {"orderable":false,"aTargets":[0]}// 制定列不参与排序
        ]
    });

    function projectProgress() {

        $("#form").submit();

    }
    /*案例-查看*/
    function picture_query(title,url){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }

</script>

</body>
</html>