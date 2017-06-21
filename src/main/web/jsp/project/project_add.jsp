<!--_meta 作为公共模版分离出去-->
<%@ page language="java" import="java.util.*"	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!--_meta 作为公共模版分离出去-->
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
	<link rel="stylesheet" href="<%=basePath%>/css/layui.css"  media="all">
<!--[if lt IE 9]>
<script type="text/javascript" src="<%=basePath%>lib/html5.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/respond.min.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/PIE_IE678.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>kindeditor/kindeditor.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>kindeditor/lang/zh_CN.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="<%=basePath%>static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>lib/Hui-iconfont/1.0.7/iconfont.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>lib/icheck/icheck.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>static/h-ui.admin/css/style.css" />
<script type="text/javascript" charset="utf-8" src="<%=basePath%>kindeditor/kindeditor.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>kindeditor/lang/zh_CN.js"></script>
<!--[if IE 6]>
<script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>kindeditor/kindeditor.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=basePath%>kindeditor/lang/zh_CN.js"></script>

<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<!--/meta 作为公共模版分离出去-->

<title>新建项目</title>
</head>
<body>
<div class="page-container">
	<form class="form form-horizontal" action="addCaseContent.do" method="post"  id="form-article-add" enctype="multipart/form-data">
		<div class="row cl">


			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>项目名称：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text"  class="input-text" style="width: 300px;" value="${content.contentTitle}" placeholder="" id="contentTitle" name="contentTitle">
			</div>
		</div>

		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>项目负责人部门：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<%--<input type="text" class="input-text" value="${content.contentSummary}" placeholder="" id="contentSummary" name="contentSummary">--%>
				<select class="select" id="department" style="width: 300px;"  name="department" size="1" onchange="department()">
					<option value="0" > 请选择 </option>
					<c:forEach items="${departmentList}" var="department">
						<option value="${department.dataid}">${department.name}</option>
					</c:forEach>
				</select>
			</div>
		</div>

		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>项目负责人：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<%--<input type="text" class="input-text" value="${content.contentSummary}" placeholder="" id="contentSummary" name="contentSummary">--%>
				<select class="select" style="width: 300px;" id="departmentName"  name="departmentName" size="1" >
					<option value="0"> 请选择 </option>


				</select>
			</div>
		</div>
		<%--<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>车型：</label>
			<div class="formControls col-xs-8 col-sm-9">
				&lt;%&ndash;<input type="text" class="input-text" value="${content.contentSummary}" placeholder="" id="contentSummary" name="contentSummary">&ndash;%&gt;
					<select class="select" id="carSystemId"  name="carSystemId" size="1">
						<option value="0"> 请选择 </option>


					</select>
			</div>
		</div>--%>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">分配人员：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<select id="province_ids" name="province_ids" multiple="multiple" size="10" style="width: 150px;" onchange="queryTwoBarand()">
					<option value="0" selected="">选择部门</option>
					<c:forEach items="${departmentList}" var="department">
						<option value="${department.dataid}">${department.name}</option>
					</c:forEach>
				</select>

				<select id="province_id" name="province_id" multiple="multiple" size="10" style="width: 150px;">
					<option value="0" selected="">选择人员</option>

				</select>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>项目开始时间：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<%--<div id="tcPreview">
					</div>
				<input type="file" name="file" id="coverImg" onchange="previewImage(this,'tcPreview')" />--%>
					<input id="hello" class="laydate-icon">

			</div>
		</div>


		<div class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
				<button onClick="article_save_submit()" class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存并提交审核</button>
				<button onClick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
			</div>
		</div>
	</form>
</div>
</div>

<!--_footer 作为公共模版分离出去-->
<%--<script type="text/javascript" src="js/previewImge.js"></script>--%>
<script type="text/javascript" src="<%=basePath%>js/jquery1.11.3.min.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/layer/2.1/layer.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/jquery.validation/1.14.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/jquery.validation/1.14.0/validate-methods.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/jquery.validation/1.14.0/messages_zh.min.js"></script>
<script type="text/javascript" src="<%=basePath%>static/h-ui/js/H-ui.js"></script>
<script type="text/javascript" src="<%=basePath%>static/h-ui.admin/js/H-ui.admin.js"></script>
<script src="<%=basePath%>laydate/laydate.js"></script>
<!--/_footer /作为公共模版分离出去-->
<script>
    laydate({
        elem: '#hello', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
        event: 'focus' //响应事件。如果没有传入event，则按照默认的click
    });
</script>
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript">
function article_save(){
	window.parent.location.reload();
}
/**分配人员*/
function selectUser() {
    layer.open({
        type: 1,
        title:"分配人员",
        area: ['600px', '400px'],
        content: $('#addUser') //这里content是一个DOM，这个元素要放在body根节点下
    });
}
/**
 * 品牌的onchange事件
 */
function  queryTwoBarand() {
	var carbrandId=$("#carbrandId").val();
	$("#carSystemId").find("option").remove();
	document.getElementById("carSystemId").options.add(new Option("请选择",0));//品牌变化一次。清空一次车型

	var  dataJson= {
		brandPid:carbrandId
	};
	$.ajax( {
		url : 'getCarBrandByCarBrandPid.do',
		type : 'post',
		contentType : 'application/json;charset=utf-8',
		dataType : 'json',
		data : JSON.stringify(dataJson),
		success : function(data) {
			if (data.success) {
				var listCarBrand= data.listCarBrand;
				var select = document.getElementById("carbrandPid");
				// document.write(listRole.length);
				//$("#carbrandPid").options.length=1;
				$("#carbrandPid").find("option").remove();
				select.options.add(new Option("请选择",0));
				for(var i = 0; i < listCarBrand.length; i++)
				{

					var id = listCarBrand[i].brandId;
					var name = listCarBrand[i].brandName;
					select.options.add(new Option(name,id));
				}
			} else {
			}
		}
	});
}
function article_save_submit() {
    var contentTitle= $("#contentTitle").val();
	var index = layer.open();
	if (contentTitle.length==0){
		layer.msg('请输入案例标题' ,{time: 2000, icon:5});
		return false;
	}
	var carbrandId=$("#carbrandId").val();
    if(carbrandId==0){
		layer.msg('请选择品牌' ,{time: 2000, icon:5});
		return false;
	}
	var carbrandPid=$("#carbrandPid").val();
	if(carbrandPid==0){
		layer.msg('请选择车系' ,{time: 2000, icon:5});
		return false;
	}
	var carSystemId=$("#carSystemId").val();
	if(carSystemId==0){
		layer.msg('请选择车型' ,{time: 2000, icon:5});
		return false;
	}
	var categoryId=$("#categoryId").val();
	if(categoryId==0){
		layer.msg('请选择改装类型' ,{time: 2000, icon:5});
		return false;
	}
	var dndArea= $("#coverImg").val();
	if(dndArea.length==0){
		layer.msg('请选择封面图片' ,{time: 2000, icon:5});
		return false;
	};

	var formData = new FormData($("#form-article-add")[0]);
	$.ajax({
		type: "POST",
		url:"addCaseContent.do",
		//data:$("#form-article-add").serialize(),// 你的formid
		data:formData,
		async: false,
		contentType: false,
		processData: false,
		error: function(request) {
			alert("Connection error");
		},
		success: function(data) {
			layer.msg('提交成功' ,{time: 20000, icon:6});
			window.parent.location.reload();
			layer.full(index);
		}
	});
	/*$("#form-article-add").submit();
	layer.msg('提交成功' ,{time: 20000, icon:6});

	window.parent.location.reload();
	layer.full(index);*/
}





</script><!--/请在上方写此页面业务相关的脚本-->
</body>
</html>