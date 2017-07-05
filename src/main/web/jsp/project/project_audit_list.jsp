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
						--%><a style="text-decoration:none" class="ml-5 add" onClick="picture_del('1','${projectAll.dataid}','${projectAll.id}')" href="javascript:;" title="同意">同意</a>
							<a style="text-decoration:none" class="ml-5 delete" onClick="picture_del('2','${projectAll.dataid}','${projectAll.id}')" href="javascript:;" title="拒绝">拒绝</a>
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
		<label class="form-label col-xs-4 col-sm-4" style="text-align: right"><span class="c-red">*</span>原因：</label>
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
$('.table-sort').dataTable({
	"aaSorting": [[ 0, "asc" ]],//默认第几个排序
	"bStateSave": false,//状态保存
	"aoColumnDefs": [
	  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
	  {"orderable":false,"aTargets":[0]}// 制定列不参与排序
	]
});

function  article_save_submit() {
    var auditId=$('#dataId').val();
    var remaek=$("#remake").val();
    var projectId=$("#projectId").val()
    var auditState=$("#auditState").val();
    var  tag="";
    if (auditState==2) {
        if (remaek.length == 0) {
            layer.msg('请输入拒绝原因!', {icon: 1, time: 3000});
            return false;
        }
        tag="拒绝";
    }

    if (auditState==1){
        tag="同意";
	}
    var  dataJson={
        auditId:auditId,
        projectId:projectId,
        auditState:auditState,
        remark:remaek
    }
    $.ajax( {
        url : '<%=basePath%>updateProjectAuditState',
        type : 'post',
        contentType : 'application/json;charset=utf-8',
        dataType : 'json',
        data : JSON.stringify(dataJson),
        success : function(data) {
            if (data.success) {
                window.location.reload();
                layer.msg('已'+tag+'!',{icon:1,time:1000});
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
		content: "selectProjectDeatil?projectId="+id
	});
	layer.full(index);

}

function picture_del(obj,projectId,auditId){
    $('#dataId').val(auditId);
    $('#projectId').val(projectId);
    $("#auditState").val(obj);
	layer.open({
        type: 1,
        title:"拒绝原因",
        area: ['600px', '360px'],
        content: $('#mark')
    })
}
</script>

</body>
</html>