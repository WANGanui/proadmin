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
    <script src="<%=basePath%>jsp/role.js"></script>
    <!--[if IE 6]>
    <script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>

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
    </style>
</head>
<body onload="_onload()">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 公告管理 <span class="c-gray en">&gt;</span> 公告列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <c:forEach items="${roles}" var="list">
    <input type="hidden" id="${list}" value="${list}">
    </c:forEach>

    <div class="cl pd-5 bg-1 bk-gray mt-20 add">
        <span class="l"><%--<a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>
         --%><a class="btn btn-primary radius" onclick="picture_add('添加公告','<%=basePath%>jsp/notice/notice_add.jsp')" href="javascript:;">
            <i class="Hui-iconfont">&#xe600;</i> 添加公告</a>
           </span> </div>
    <div class="mt-20">
        <table class="table table-border table-bordered table-bg table-hover table-sort">
            <thead>
            <tr class="text-c">
                <th width="40">序号</th>
                <th width="60">公告标题</th>
                <th width="200">公告内容</th>
                <th width="60">创建时间</th>
                <th width="80">发布人</th>
                <th  width="60">发布部门</th>
                <th width="60">发布日期</th>
                <th width="60">状态</th>
                <th width="100">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${list}" var="notice" varStatus="noticeIndex">
                <tr class="text-c">

                    <td>${noticeIndex.index+1}</td>
                    <td>${notice.title}</td>
                    <td>${notice.context}</td>
                    <td class="td-time"><fmt:formatDate value="${notice.createtime}" pattern="yyyy-MM-dd" /></td>
                    <td>${notice.worker}</td>
                    <td>${notice.department}</td>
                    <td class="td-time"><fmt:formatDate value="${notice.time}" pattern="yyyy-MM-dd" /></td>
                    <td class="td-status"><c:if test="${notice.isread==0}"><span class="label label-success radius" style="background-color: #00a0e9">	未读 </span></c:if>
                        <c:if test="${notice.isread==1}"> <span class="label label-success radius">已读</span></c:if>
                    </td>
                    <td class="td-manage">

                        <c:if test="${notice.isread==0}">
                            <a style="text-decoration:none;font-size: 16px;" class="ml-5" onClick="picture_shenhe(this,'${notice.noticeWorkId}')"  href="javascript:;" >阅</a>
                        </c:if>
                        <a style="text-decoration:none" class="ml-5 delete" onClick="picture_del('${notice.dataid}')" href="javascript:;" title="修改"><i class="Hui-iconfont">&#xe6e2;</i></a>
                        <a style="text-decoration:none" class="ml-5 delete" onClick="picture_query('修改公告','<%=basePath%>toeditNotice?dataid=${notice.dataid}')" href="javascript:;" title="修改"><i class="Hui-iconfont">&#xe60c;</i></a>

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
<script type="text/javascript" src="static/h-ui/js/ZeroClipboard.js"></script><%--
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
            {"orderable":false,"aTargets":[0,8]}// 制定列不参与排序
        ]
    });
    /*案例-添加*/
    function picture_add(title,url){
        var index = layer.open({
            type: 2,
            title: title,
            content: url,

        });
        layer.full(index);
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

    function selectContent(title,id){
        var index = layer.open({
            type: 2,
            title: title,
            content: "getTitleByContentId.do?contentId="+id
        });
        layer.full(index);
    }

    /*图片-查看*/
    function picture_show(title,url,id){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*图片-审核*/
    function picture_shenhe(obj,id){
        layer.confirm('确认已阅读该公告？', function(index) {

            var  dataJson={
                status:1,
                dataid:id
            }

            $.ajax( {
                url : 'updateStatusNoticeRelWorker',
                type : 'post',
                contentType : 'application/json;charset=utf-8',
                dataType : 'json',
                data : JSON.stringify(dataJson),
                success : function(data) {
                    if (data.success) {
                        $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已读</span>');
                        $(obj).remove();
                        layer.msg('已阅读', {icon: 6, time: 2000});
                    } else {

                    }
                }
            });



        });
    }
    /*图片-下架*/
    function picture_stop(obj,id){
        layer.confirm('确认要下架吗？',function(index){

            var  dataJson={
                status:0,
                modular:"update",
                contentId:id
            }

            $.ajax( {
                url : 'updateStatusOrDeleteByContent.do',
                type : 'post',
                contentType : 'application/json;charset=utf-8',
                dataType : 'json',
                data : JSON.stringify(dataJson),
                success : function(data) {
                    if (data.success) {
                        $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick="picture_start(this,'+id+')" href="javascript:;" title="发布"><i class="Hui-iconfont">&#xe603;</i></a>');
                        $(obj).parents("tr").find(".td-status").html('<span class="label label-defaunt radius">已下架</span>');
                        $(obj).remove();
                        layer.msg('已下架!',{icon: 5,time:1000});
                    } else {

                    }
                }
            });



        });
    }

    /*图片-发布*/
    function picture_start(obj,id){
        layer.confirm('确认要发布吗？',function(index){
            var  dataJson={
                status:1,
                modular:"update",
                contentId:id
            }
            $.ajax( {
                url : 'updateStatusOrDeleteByContent.do',
                type : 'post',
                contentType : 'application/json;charset=utf-8',
                dataType : 'json',
                data : JSON.stringify(dataJson),
                success : function(data) {
                    if (data.success) {
                        $(obj).parents("tr").find(".td-manage").prepend('<a style="text-decoration:none" onClick=picture_stop(this,'+id+') href="javascript:;" title="下架"><i class="Hui-iconfont">&#xe6de;</i></a>');
                        $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已发布</span>');
                        $(obj).remove();
                        layer.msg('已发布!',{icon: 6,time:1000});
                    } else {

                    }
                }
            });

        });
    }
    /*图片-申请上线*/
    function picture_shenqing(obj,id){
        $(obj).parents("tr").find(".td-status").html('<span class="label label-default radius">待审核</span>');
        $(obj).parents("tr").find(".td-manage").html("");
        layer.msg('已提交申请，耐心等待审核!', {icon: 1,time:2000});
    }
    /*编辑*/
    function picture_edit(title,url,id) {
            var index = layer.open({
                title: title,
                content: url+"?dataid="+id
            });
            layer.full(index);
    }
    /*图片-删除*/
    function picture_del(id){
        layer.confirm('确认要删除吗？',function(index){

            var  dataJson={
                dataid:id
            }
            $.ajax( {
                url : '<%=basePath%>deleteNotice',
                type : 'post',
                contentType : 'application/json;charset=utf-8',
                dataType : 'json',
                data : JSON.stringify(dataJson),
                success : function(data) {
                    if (data.success) {
                        location.replace(location.href)
                        layer.msg('已删除!',{icon:1,time:1000});
                    } else {

                    }
                }
            });
        });
    }
    $("#DataTables_Table_0_paginate").on('click',function () {
        _onload();
    });

    $("#DataTables_Table_0_length").on('click',function () {
            _onload();
        }
    )
</script>

</body>
</html>