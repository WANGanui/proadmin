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

</head>
<body onload="_onload()">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 项目管理 <span class="c-gray en">&gt;</span> 项目列表 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
	<c:forEach items="${roles}" var="list">
		<input type="hidden" id="${list}" value="${list}">
	</c:forEach>
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
					<td class="td-status"><c:if test="${projectAll.state==1}">
						<span class="label label-success radius">	审核完成 </span>
					</c:if>
						<c:if test="${projectAll.state==0}">
							<span class="label radius" style="background-color:red">	待审核</span>
						</c:if>

					<c:if test="${projectAll.state==2}">
						<span class="label radius" style="background-color: #9effff">	审核中</span>
					</c:if>

					</td>


					<td class="td-time">${projectAll.progress}</td>
					<td class="td-manage">
						<%--<a style="text-decoration:none" class="ml-5" onClick="picture_edit('详情','getContentCaseByContentId.do','${project.dataid}')" href="javascript:;" title="详情"><i class="Hui-iconfont">&#xe6df;</i></a>
						--%><a style="text-decoration:none" class="ml-5 add" onClick="picture_del('创建任务','${projectAll.dataid}')" href="javascript:;" title="创建任务"><i class="Hui-iconfont">&#xe61f;</i></a>
							<a style="text-decoration:none" class="ml-5 delete" onClick="picture_delte('删除项目','${projectAll.dataid}')" href="javascript:;" title="删除项目"><i class="Hui-iconfont" style="font-size: 20px;">&#xe6e2;</i></a>
					</td>
				</tr>
</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<div  id="mark" style="display: none">
	<div class="row cl">
		<input type="hidden" value="" id="dataId"/>
		<input type="hidden" value="" id="projectId"/>
		<input type="hidden" value="" id="auditState" />
		<label class="form-label col-xs-4 col-sm-4" style="text-align: right"><span class="c-red">*</span>删除原因：</label>
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

function  article_save_submit() {

    var  id=$("#dataId").val();
    var  remake=$("#remake").val();
    var  dataJson={
        status:1,
        modular:"delete",
        contentId:id,
        remake:remake
    }
    $.ajax( {
        url : '<%=basePath%>deleteProject',
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

}


/*图片-编辑*/
function queryDetaila(id) {

	var index = layer.open({
		type: 2,
		title: "项目详情",
		content: "<%=basePath%>selectProjectDeatil?projectId="+id
	});
	layer.full(index);

}
/*图片-删除*/
function picture_delte(obj,id){
	layer.confirm('确认要删除项目吗？',function(index){

$("#dataId").val(id);
        layer.open({
            type: 1,
            title:"删除原因",
            area: ['600px', '360px'],
            content: $('#mark')
        })

	});
}

function picture_del(obj,id){
    layer.confirm('确认要创建任务吗？',function(index){

        var index = layer.open({
            type: 2,
            title: "创建任务",
            content: "<%=basePath%>missionAdd"
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
$(".paginate_button").click(function () {
        _onload();
    }
)
</script>

</body>
</html>