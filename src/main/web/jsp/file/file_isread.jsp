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
    <link rel="stylesheet" href="<%=basePath%>css/layui.css"  media="all">
    <!--[if IE 6]>
    <script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>

    <![endif]-->
    <style type="text/css">
        .background{
            background:#00FFFF;
        }
    </style>
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

<div class="page-container">


    <c:forEach items="${roles}" var="list">
        <input type="hidden" id="${list}" value="${list}">
    </c:forEach>
    <div class="mt-20">
        <div id="div1" >
            <table class="table table-border table-bordered table-bg table-hover table-sort" id="table1">
                <thead>
                <tr class="text-c">
                    <th width="40">序号</th>
                    <th width="200">姓名</th>
                    <th width="40">是否已阅</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach items="${optionList}" var="item" varStatus="missionIndex1">
                    <tr class="text-c" >
                        <td>${missionIndex1.index+1}</td>
                        <td>${item.workername}</td>
                        <td class="td-status"><c:if test="${item.isread==0}"><span class="label label-success radius" style="background-color: #00a0e9">	未读 </span></c:if>
                            <c:if test="${item.isread==1}"> <span class="label label-success radius">已读</span></c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</div>

<script type="text/javascript" src="<%=basePath%>lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="<%=basePath%>static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="<%=basePath%>static/h-ui/js/ZeroClipboard.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="<%=basePath%>static/h-ui.admin/js/H-ui.admin.js"></script>
<script type="text/javascript" src="<%=basePath%>jsp/role.js"/>
<%--
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
        layer.confirm('审核文章？', {
                btn: ['通过','不通过'],
                shade: false
            },
            function(){
                $(obj).parents("tr").find(".td-manage").prepend('<a class="c-primary" onClick="picture_start(this,id)" href="javascript:;" title="申请上线">申请上线</a>');
                $(obj).parents("tr").find(".td-status").html('<span class="label label-success radius">已发布</span>');
                $(obj).remove();
                layer.msg('已发布', {icon:6,time:1000});
            },
            function(){
                $(obj).parents("tr").find(".td-manage").prepend('<a class="c-primary" onClick="picture_shenqing(this,id)" href="javascript:;" title="申请上线">申请上线</a>');
                $(obj).parents("tr").find(".td-status").html('<span class="label label-danger radius">未通过</span>');
                $(obj).remove();
                layer.msg('未通过', {icon:5,time:1000});
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
    /*图片-编辑*/
    function picture_edit(title,url,id) {
        var status = $("#status" + id).text().trim();
        if (status=='已下架') {
            var index = layer.open({
                type: 2,
                title: title,
                content: url+"?contentId="+id
            });
            layer.full(index);
        }else {
            layer.msg('请先下架!',{icon:1,time:2000});
        }
    }

    function show1() {
        document.getElementById("div1").style.display = "";
        document.getElementById("div2").style.display = "none";
        document.getElementById("div3").style.display = "none";
        document.getElementById("div4").style.display = "none";
        $("#auction1").removeClass('background');
        $("#auction2").removeClass('background');
        $("#auction3").removeClass('background');
        $("#auction").addClass('background');

    }
    function show2() {
        document.getElementById("div1").style.display = "none";
        document.getElementById("div2").style.display = "";
        document.getElementById("div3").style.display = "none";
        document.getElementById("div4").style.display = "none";
        $("#auction").removeClass('background');
        $("#auction2").removeClass('background');
        $("#auction3").removeClass('background');
        $("#auction1").addClass('background');

    }
    function show3() {
        document.getElementById("div1").style.display = "none";
        document.getElementById("div2").style.display = "none";
        document.getElementById("div3").style.display = "";
        document.getElementById("div4").style.display = "none";
        $("#auction1").removeClass('background');
        $("#auction3").removeClass('background');
        $("#auction").removeClass('background');
        $("#auction2").addClass('background');
    }
    function show4() {
        document.getElementById("div1").style.display = "none";
        document.getElementById("div2").style.display = "none";
        document.getElementById("div3").style.display = "none";
        document.getElementById("div4").style.display = "";
        $("#auction1").removeClass('background');
        $("#auction2").removeClass('background');
        $("#auction").removeClass('background');
        $("#auction3").addClass('background');
    }

    /*图片-删除*/
    function picture_del(id){
        layer.confirm('确认要删除吗？',function(){
            var  dataJson={
                dataid:id
            }
            $.ajax( {
                url : '<%=basePath%>deleteMission',
                type : 'post',
                contentType : 'application/json;charset=utf-8',
                dataType : 'json',
                data : JSON.stringify(dataJson),
                success : function(data) {
                    if (data.success) {
                        location.replace(location.href)
                        layer.msg('已删除!',{icon:1,time:1000});
                    } else {
                        layer.msg('删除失败',{icon:1,time:1000});
                    }
                }
            });
        });
    }
    $("#table1_length").on('click',function () {
        _onload();
    });

    $("#table1_paginate").on('click',function () {
            _onload();
        }
    )

    function query() {
        $("#missionList").submit();
        /*
         var  roleid=$("#roleid").val();
         var  logmin=$("#logmin").val();
         var projectDept=$("#projectDept").val();
         var  dataJson={
         roleid:roleid,
         logmin:logmin,
         projectDept:projectDept
         }
         $.ajax( {
         url : '<%=basePath%>deleteMission',
         type : 'post',
         contentType : 'application/json;charset=utf-8',
         dataType : 'json',
         data : JSON.stringify(dataJson),
         success : function(data) {
         if (data.success) {
         location.replace(location.href)
         layer.msg('已删除!',{icon:1,time:1000});
         } else {
         layer.msg('删除失败',{icon:1,time:1000});
         }
         }
         });
         window.location.href="http://localhost:8080//selectListExample?roleid="+roleid+"&logmin="+logmin+"&projectDept="+projectDept;
         */ }
</script>

</body>
</html>