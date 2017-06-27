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
    <script src="<%=basePath%>jsp/role.js">
        <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->

    <title>项目列表</title>
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
        .Hui-iconfont{
            font-size: 20px;
        }
        #table2_filter{
            display: none!important;
        }
        #table2_length label{
            display: none!important;
        }
        #DataTables_Table_0_filter{
            display: none!important;
        }
        #DataTables_Table_0_length label{
            display: none!important;
        }
        #DataTables_Table_0_paginate{
            display: none!important;
        }
    </style>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 我的桌面   <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">


    <div class="mt-20">
        <table class="table table-border table-bordered table-bg table-hover table-sort">
            <thead>
            <tr class="text-c">
                <th width="40">序号</th>
                <th width="60">公告标题</th>
                <th width="200">公告内容</th>
                <th width="80">发布人</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${map.notice}" var="notice" varStatus="noticeIndex">
                <tr class="text-c">

                    <td>${noticeIndex.index+1}</td>
                    <td>${notice.title}</td>
                    <td>${notice.context}</td>
                    <td>${notice.worker}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="page-container">
    <div id="div2" class="mt-20">
        <table class="table table-border table-bordered table-bg table-hover table-sort" id="table2">
            <thead>
            <tr class="text-c">
                <th width="40">序号</th>
                <th width="60">任务名称</th>
                <th width="80">开始时间</th>
                <th width="80">计划结束时间</th>
                <th  width="60">项目名称</th>
                <th width="60">完成百分比</th>
                <th width="60">任务比重</th>
                <th width="60">创建人</th>
                <th width="60">审核人</th>
                <th width="60">责任人</th>
                <th width="60">类型</th>
                <th width="60">项目阶段</th>
                <th width="60">流程状态</th>
                <th width="60">任务状态</th>
            </tr>
            </thead>

            <tbody>
            <c:forEach items="${map.mission}" var="mission2" varStatus="missionIndex2">
                <tr class="text-c">

                    <td>${missionIndex2.index+1}</td>
                    <td onclick="picture_query('任务详情','<%=basePath%>missionDetail?dataid=${mission2.dataid}')" style="text-decoration:underline">${mission2.name}</td>
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
                    <td class="td-status">
                        <span class="label label-success radius">${mission2.level}</span>
                    </td>
                    <td class="td-status"><c:if test="${mission2.state==0}">
                        <span class="label label-success radius" style="background-color: #00a0e9">	未开始 </span>
                    </c:if>
                        <c:if test="${mission2.state==1}">
                            <span class="label label-success radius" style="background-color: #985f0d">进行中</span>
                        </c:if>
                        <c:if test="${mission2.state==2}">
                            <span class="label label-success radius">已完成</span>
                        </c:if>
                    </td>
                    <td class="td-status"><c:if test="${mission2.missionstate==0}">
                        <span class="label label-success radius">	已同意 </span>
                    </c:if>
                        <c:if test="${mission2.missionstate==1}">
                            <span class="label label-success radius" style="background-color: #985f0d">已拒绝</span>
                        </c:if>
                        <c:if test="${mission2.missionstate==2}">
                            <span class="label label-success radius" style="background-color: #00a0e9">待审核</span>
                        </c:if>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</div>
<script type="text/javascript" src="<%=basePath%>lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="<%=basePath%>static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="<%=basePath%>static/h-ui/js/ZeroClipboard.js"></script><%--
<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/zeroclipboard/2.1.6/ZeroClipboard.min.js" ></script>--%>
<script type="text/javascript">
    function  obj(id) {
        var clip = new ZeroClipboard.Client();
        ZeroClipboard.setMoviePath("ZeroClipboard.swf");
        clip.setHandCursor(true);
        clip.setText("http://www.5cpr.com/mobile/share.do?id="+id+"&type=2");
        clip.addEventListener('complete', function (client) {
            layer.msg('复制成功', {time: 2000, icon: 6});
        });
        clip.glue('J_copy_clipboard_data'+id);
    }
</script>
<script type="text/javascript">
    $('.table-sort').dataTable({
        "aaSorting": [[ 0, "asc" ]],//默认第几个排序
        "bStateSave": false,//状态保存
        "aoColumnDefs": [
            //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
            {"orderable":false,"aTargets":[0]}// 制定列不参与排序
        ]
    });
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