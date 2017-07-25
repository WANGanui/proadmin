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
      /*  textarea{
            border:0;
            background-color:transparent;
            !*scrollbar-arrow-color:yellow;
            scrollbar-base-color:lightsalmon;
            overflow: hidden;*!
            color: #666464;
            height: auto;
        }*/
        .Hui-iconfont{
            font-size: 20px;
        }
    </style>
</head>
<body onload="_onload()">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 任务管理 <span class="c-gray en">&gt;</span> 任务列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
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
                    <th width="60">任务名称</th>
                    <th width="100">任务内容</th>
                    <th width="80">开始时间</th>
                    <th width="80">计划结束时间</th>
                    <th  width="60">项目名称</th>
                    <th width="60">进度</th>
                    <th width="60">任务比重</th>
                    <th width="60">创建人</th>
                    <th width="60">责任人</th>
                    <th width="60">类型</th>
                    <th width="70">任务状态</th>
                    <th width="70">流程状态</th>
                    <th width="100">操作</th>
                </tr>
                </thead>

                <tbody>
                <c:forEach items="${list}" var="mission1" varStatus="missionIndex1">
                    <tr class="text-c"<c:if test="${mission1.finishtime>mission1.endtime}"> style="background-color: red" </c:if>>

                        <td>${missionIndex1.index+1}</td>
                        <td onclick="picture_query('任务详情','<%=basePath%>missionDetail?dataid=${mission1.dataid}')" style="text-decoration:underline">${mission1.name}</td>
                        <td>${mission1.context}</td>
                        <td class="td-time"><fmt:formatDate value="${mission1.starttime}" pattern="yyyy-MM-dd" /></td>
                        <td class="td-time"><fmt:formatDate value="${mission1.endtime}" pattern="yyyy-MM-dd" /></td>
                        <td>${mission1.proname}</td>
                        <td>${mission1.percentage}</td>
                        <td>${mission1.proportion}级</td>
                        <td>${mission1.creator}</td>
                        <td>${mission1.headername}</td>
                        <td class="td-status"><c:if test="${mission1.type==0}">
                            <span class="label label-success radius">	项目任务 </span>
                        </c:if>
                            <c:if test="${mission1.type==1}">
                                <span class="label label-success radius">个人任务</span>
                            </c:if>
                        </td>
                        <td class="td-status">
                            <c:if test="${mission1.state==0}">
                            <span class="label label-success radius" style="background-color: #00a0e9">	未开始 </span>
                            </c:if>
                            <c:if test="${mission1.state==1}">
                                <span class="label label-success radius">进行中</span>
                            </c:if>
                            <c:if test="${mission1.state==2}">
                                <span class="label label-success radius">已完成</span>
                            </c:if>
                        </td>
                        <td class="td-status"><c:if test="${mission1.missionstate==0}">
                            <span class="label label-success radius">	已同意 </span>
                        </c:if>
                            <c:if test="${mission1.missionstate==1}">
                                <span class="label label-success radius">已拒绝</span>
                            </c:if>
                            <c:if test="${mission1.missionstate==2}">
                                <span class="label label-success radius" style="background-color: #00a0e9">待审核</span>
                            </c:if>
                        </td>
                        <td class="td-manage">
                            <a style="text-decoration:none" class="ml-5 delete" onClick="return picture_del(this,0,'${mission1.dataid}',${mission1.state})" href="javascript:;" title="同意">同意</a>
                            <a style="text-decoration:none" class="ml-5 update" onClick="return picture_del(this,1,'${mission1.dataid}',${mission1.state})" href="javascript:;" title="拒绝">拒绝</a>
                            <c:if test="${mission1.state==2}">
                                <a style="text-decoration:none" class="ml-5 update" onClick="picture_query('进度详情','<%=basePath%>/missionjindu?dataid=${mission1.dataid}')" title="进度详情"><i class="Hui-iconfont">&#xe667;</i></a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>

                </tbody>
            </table>
        </div>
    </div>


</div>
</div>
<div  id="mark" style="display: none">
<div class="row cl">
    <input type="hidden" value="" id="dataId"/>
    <label class="form-label col-xs-4 col-sm-4" style="text-align: right"><span class="c-red">*</span>拒绝原因：</label>
    <div class="formControls col-xs-8 col-sm-6">
        <textarea id="remake" rows="10"cols="25"></textarea>
    </div>
</div>
    <br/>
<div id="but" class="row cl">
    <div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-5">
        <button onClick="article_save_submit()"  class="btn btn-primary radius" type="button">保存并提交</button>
        <%--<button onClick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
    --%></div>
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
            {"orderable":false,"aTargets":[0,13]}// 制定列不参与排序
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
    function picture_del(obj,state,id,mes){
        sta="";
        if(state==0) {
            sta="同意";
        }
        if(state==1) {
            sta="拒绝";
        }

        layer.confirm('确认'+sta+'该任务审核吗？',function(){
            if(state==0) {
                var  dataJson={
                    dataId:id,
                    missionState:0,
                    remark:"",
                    mes:mes
                }
                $.ajax( {
                    url : '<%=basePath%>updateState',
                    type : 'post',
                    contentType : 'application/json;charset=utf-8',
                    dataType : 'json',
                    data : JSON.stringify(dataJson),
                    success : function(data) {
                        if (data.success) {
                            //window.location.reload();
                            $(obj).parent().parent().remove();
                            layer.msg('已同意!',{icon:1,time:3000});
                        } else {

                        }
                    }
                });
            }
            if(state==1) {
                $('#dataId').val(id);
                layer.open({
                    type: 1,
                    title:"拒绝原因",
                    area: ['600px', '360px'],
                    content: $('#mark')
                })
            }

       /*     var  dataJson={
                dataid:id
            }
            $.ajax( {
                url : 'deleteMission',
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
       */ });
        return false;
    }
    function  article_save_submit() {
var id=$('#dataId').val();
var remaek=$("#remake").val();
if (remaek.length==0){
    layer.msg('请输入拒绝原因!',{icon:1,time:3000});
    return false;
}
        var  dataJson={
            dataId:id,
            missionState:1,
            remark:remaek,
            mes:8
        }
        $.ajax( {
            url : '<%=basePath%>updateState',
            type : 'post',
            contentType : 'application/json;charset=utf-8',
            dataType : 'json',
            data : JSON.stringify(dataJson),
            success : function(data) {
                if (data.success) {
                    window.location.reload();
                    layer.msg('已拒绝!',{icon:1,time:1000});
                } else {

                }
            }
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