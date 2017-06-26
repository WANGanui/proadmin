<!--_meta 作为公共模版分离出去-->
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <!--[if lt IE 9]>
    <script type="text/javascript" src="<%=basePath%>lib/html5.js"></script>
    <script type="text/javascript" src="<%=basePath%>lib/respond.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>lib/PIE_IE678.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>lib/Hui-iconfont/1.0.7/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>lib/icheck/icheck.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/h-ui.admin/skin/default/skin.css" id="skin"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>static/h-ui.admin/css/style.css"/>
    <!--[if IE 6]>
    <script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js"></script>

    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <style type="text/css">
        .background{
            background:#00FFFF;
        }
    </style>
    <title>个人任务列表</title>

</head>
<style>

</style>
<body>


<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 个人管理 <span class="c-gray en">&gt;</span> 个人任务列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px"  href="javascript:location.replace(location.href);" title="刷新"><i  class="Hui-iconfont">&#xe68f;</i></a></nav>

<%-- <th >
     <button style="width: 400px; height: 50px;background:#00FFFF ;border-radius: 10px;"
             onClick="show1()">日增用户
     </button>
 </th>
 <th colspan="2">
     <button style="width: 400px; height: 50px;background:#00FFFF ;border-radius: 10px;"  onClick="show2()">日增工程师/机构
     </button>
 </th>--%>

<div class="page-container" style="padding-top: 10px;">
    <c:forEach items="${roles}" var="list">
        <input type="hidden" id="${list}" value="${list}">
    </c:forEach>
    <div class="cl mt-20">
        <div id="auction1" style="border: 1px solid #DCDCDC ;float:left; width: 150px;height: 40px;text-align:center;line-height: 40px ;font-size: 16px; "class="background" onclick="show1()" ><span  ><b>个人任务</b></span></div>
        <div id="auction"  style="border: 1px solid #DCDCDC;float:left; width: 150px;height: 40px;text-align:center;line-height: 40px; font-size: 16px;"   onclick="show2()"><b>项目任务</b></div>
    </div>
    <div class="mt-20">
        <div id="div1" >
            <table class="table table-border table-bordered table-bg table-hover table-sort" id="table1">
                <thead>
                <tr class="text-c">
                    <th width="40">序号</th>
                    <th width="60">任务名称</th>
                    <th width="150">任务内容</th>
                    <th width="80">开始时间</th>
                    <th width="80">计划结束时间</th>
                    <th  width="60">项目名称</th>
                    <th width="60">完成百分比</th>
                    <th width="60">任务比重</th>
                    <th width="60">创建人</th>
                    <th width="60">审核人</th>
                    <th width="60">责任人</th>
                    <th width="60">类型</th>
                    <th width="60">状态</th>
                    <th width="100">操作</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach items="${map.list1}" var="mission1" varStatus="missionIndex1">
                    <tr class="text-c">

                        <td>${missionIndex1.index+1}</td>
                        <td onclick="picture_query('任务详情','missionDetail?dataid=${mission1.dataid}')" style="text-decoration:underline">${mission1.name}</td>
                        <td>${mission1.context}</td>
                        <td class="td-time"><fmt:formatDate value="${mission1.starttime}" pattern="yyyy-MM-dd" /></td>
                        <td class="td-time"><fmt:formatDate value="${mission1.endtime}" pattern="yyyy-MM-dd" /></td>
                        <td>${mission1.proname}</td>
                        <td>${mission1.percentage}</td>
                        <td>${mission1.proportion}</td>
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
                        <td class="td-status"><c:if test="${mission1.state==0}">
                            <span class="label label-success radius">	已发布 </span>
                        </c:if>
                            <c:if test="${mission1.state==1}">
                                <span class="label label-success radius">进行中</span>
                            </c:if>
                            <c:if test="${mission1.state==2}">
                                <span class="label label-success radius">待审核</span>
                            </c:if>
                            <c:if test="${mission1.state==3}">
                                <span class="label label-success radius">已完成</span>
                            </c:if>
                        </td>
                        <td class="td-manage">
                            <a style="text-decoration:none" class="ml-5 update" onClick="picture_edit('详情','getContentCaseByContentId.do','${mission1.dataid}')" href="javascript:;" title="详情"><i class="Hui-iconfont">&#xe6df;</i></a>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>
        <div id="div2" style="display:none">
            <table class="table table-border table-bordered table-bg table-hover table-sort" id="table2">
                <thead>
                <tr class="text-c">
                    <th width="40">序号</th>
                    <th width="60">任务名称</th>
                    <th width="150">任务内容</th>
                    <th width="80">开始时间</th>
                    <th width="80">计划结束时间</th>
                    <th  width="60">项目名称</th>
                    <th width="60">完成百分比</th>
                    <th width="60">任务比重</th>
                    <th width="60">创建人</th>
                    <th width="60">审核人</th>
                    <th width="60">责任人</th>
                    <th width="60">类型</th>
                    <th width="60">状态</th>
                    <th width="100">操作</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach items="${map.list2}" var="mission2" varStatus="missionIndex2">
                    <tr class="text-c">

                        <td>${missionIndex2.index+1}</td>
                        <td onclick="picture_query('任务详情','missionDetail?dataid=${mission1.dataid}')" style="text-decoration:underline">${mission2.name}</td>
                        <td>${mission2.context}</td>
                        <td class="td-time"><fmt:formatDate value="${mission2.starttime}" pattern="yyyy-MM-dd" /></td>
                        <td class="td-time"><fmt:formatDate value="${mission2.endtime}" pattern="yyyy-MM-dd" /></td>
                        <td>${mission2.proname}</td>
                        <td>${mission2.percentage}</td>
                        <td>${mission2.proportion}</td>
                        <td>${mission2.creator}</td>
                        <td>${mission2.auditorname}</td>
                        <td>${mission2.headername}</td>
                        <td class="td-status"><c:if test="${mission2.type==0}">
                            <span class="label label-success radius">	项目任务 </span>
                        </c:if>
                            <c:if test="${mission2.type==1}">
                                <span class="label label-success radius">个人任务</span>
                            </c:if>
                        </td>
                        <td class="td-status"><c:if test="${mission2.state==0}">
                            <span class="label label-success radius">	已发布 </span>
                        </c:if>
                            <c:if test="${mission2.state==1}">
                                <span class="label label-success radius">进行中</span>
                            </c:if>
                            <c:if test="${mission2.state==2}">
                                <span class="label label-success radius">待审核</span>
                            </c:if>
                            <c:if test="${mission2.state==3}">
                                <span class="label label-success radius">已完成</span>
                            </c:if>
                        </td>
                        <td class="td-manage">
                            <a style="text-decoration:none" class="ml-5 update" onClick="picture_edit('详情','getContentCaseByContentId.do','${mission2.dataid}')" href="javascript:;" title="详情"><i class="Hui-iconfont">&#xe6df;</i></a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

    </div>
</div>

<script src="<%=basePath%>jsp/role.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="<%=basePath%>static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript">

    $('.table-sort').dataTable({
        "aaSorting": [[ 0, "desc" ]],//默认第几个排序
        "bStateSave": false,//状态保存
        "aoColumnDefs": [
            //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
            // {"orderable":false,"aTargets":[2]}// 制定列不参与排序
        ]
    });

</script>
<script>

    function show1() {
        document.getElementById("div1").style.display = "";
        document.getElementById("div2").style.display = "none";
        $("#auction").removeClass('background');
        $("#auction1").addClass('background');


    }
    function show2() {
        document.getElementById("div1").style.display = "none";
        document.getElementById("div2").style.display = "";
        $("#auction1").removeClass('background');
        $("#auction").addClass('background');

    }
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