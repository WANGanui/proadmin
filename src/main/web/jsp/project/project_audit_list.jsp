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
</style>
</head>
<body onload="_onload()">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 项目管理 <span class="c-gray en">&gt;</span> 项目列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	<c:forEach items="${roles}" var="list">
		<input type="hidden" id="${list}" value="${list}">
	</c:forEach>
	<div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><%--<a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a> --%><%--<a class="btn btn-primary radius add" onclick="picture_add('新建项目','/projectAdd')" href="javascript:;"><i class="Hui-iconfont">&#xe600;</i> 新建项目</a> --%> <%--<a class="btn btn-primary radius" onclick="picture_query('精选案例','getAllContentPickup.do?contentType=2')" href="javascript:;"><i class="Hui-iconfont">&#xe695;</i> 查看精选案例</a>--%></span> </div>
	<div class="mt-20">
		<table class="table table-border table-bordered table-bg table-hover table-sort">
			<thead>
				<tr class="text-c">
					<th width="40">序号</th>
					<th width="140">项目名称</th>
					<th width="100">开始时间</th>
					<th width="100">预计结束时间</th>
					<th width="60">项目负责人</th>
					<th  width="60">状态</th>
					<th width="60">项目进度</th>
					<th width="100">操作</th>
				</tr>
			</thead>
			<tbody>
<c:forEach items="${projectList}" var="projectAll" varStatus="projectIndex">
				<tr class="text-c">

					<td>${projectIndex.index+1}</td>
					<td onclick="queryDetaila('${projectAll.dataid}')" style="text-decoration:underline">${projectAll.name}</td>
					<td class="td-time"><fmt:formatDate value="${projectAll.starttime}" pattern="yyyy-MM-dd" /></td>
					<td class="td-time"><fmt:formatDate value="${projectAll.endtime}" pattern="yyyy-MM-dd" /></td>
					<td>${projectAll.leader}</td>
					<td class="td-status"><c:if test="${projectAll.auditstate==1}">
						<span class="label label-success radius">	已同意 </span>
					</c:if>
						<c:if test="${projectAll.auditstate==2}">
							<span class="label label-success radius">	已拒绝 </span>
						</c:if>
						<c:if test="${projectAll.auditstate==0}">
							<span class="label radius" style="background-color:red">待审核</span>
						</c:if>
					</td>


					<td class="td-time">${projectAll.progress}</td>
					<td class="td-manage">
						<%--<a style="text-decoration:none" class="ml-5" onClick="picture_edit('详情','getContentCaseByContentId.do','${project.dataid}')" href="javascript:;" title="详情"><i class="Hui-iconfont">&#xe6df;</i></a>
						--%><a style="text-decoration:none" class="ml-5 add" onClick="picture_del('0','${projectAll.dataid}')" href="javascript:;" title="同意">同意</a>
							<a style="text-decoration:none" class="ml-5 delete" onClick="picture_delte('1','${projectAll.dataid}')" href="javascript:;" title="拒绝">拒绝</a>
					</td>
				</tr>
</c:forEach>
			</tbody>
		</table>
	</div>
</div>
<script src="<%=basePath%>/jsp/role.js"></script>
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

/*图片-编辑*/
function queryDetaila(id) {

	var index = layer.open({
		type: 2,
		title: "项目详情",
		content: "selectProjectDeatil?projectId="+id
	});
	layer.full(index);

}
/*图片-删除*/
function picture_delte(obj,id){
	layer.confirm('确认要删除项目吗？',function(index){

		var  dataJson={
			status:1,
			modular:"delete",
			contentId:id
		}
		$.ajax( {
			url : 'deleteProject',
			type : 'post',
			contentType : 'application/json;charset=utf-8',
			dataType : 'json',
			data : JSON.stringify(dataJson),
			success : function(data) {
				if (data.success) {
					//$(obj).parents("tr").remove();
					location.replace(location.href)
					layer.msg('已删除!',{icon:1,time:1000});
				} else {

				}
			}
		});



	});
}

function picture_del(obj,id){
    layer.confirm('确认要创建任务吗？',function(index){

        var index = layer.open({
            type: 2,
            title: "创建任务",
            content: "missionAdd"
        });
        layer.full(index);
		/*	var  dataJson={
		 status:1,
		 modular:"delete",
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
		 //$(obj).parents("tr").remove();
		 location.replace(location.href)
		 layer.msg('已删除!',{icon:1,time:1000});
		 } else {

		 }
		 }
		 });
		 */


    });
}
</script>

</body>
</html>