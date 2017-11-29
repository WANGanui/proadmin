<!--_meta 作为公共模版分离出去-->
<%@ page language="java" import="java.util.*"	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

<title>项目详情</title>
	<style>
		table,table tr th, table tr td { border:1px solid #0094ff; }
	</style>
</head>
<body>
<div class="page-container">
	<form class="form form-horizontal" action="addCaseContent.do" method="post"  id="form-article-add" enctype="multipart/form-data">
		<div class="row cl">


			<label class="form-label col-xs-4 col-sm-2">项目名称：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text"  class="input-text" style='border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' readonly style="width: 300px;" value="${project.name}" placeholder="" id="contentTitle" name="contentTitle">
			</div>
		</div>

		<%--<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>项目负责人部门：</label>
			<div class="formControls col-xs-8 col-sm-9">
				&lt;%&ndash;<input type="text" class="input-text" value="${content.contentSummary}" placeholder="" id="contentSummary" name="contentSummary">&ndash;%&gt;
				<select class="select" id="department" style="width: 300px;"  name="department" size="1" onchange="departmentUser()">
					<option value="0" > 请选择 </option>
					<c:forEach items="${departmentList}" var="department">
						<option value="${department.dataid}">${department.name}</option>
					</c:forEach>
				</select>
			</div>
		</div>
--%>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">项目负责人：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<input type="text" style='border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' class="input-text" readonly value="${project.leader}" placeholder="" id="contentSummary" name="contentSummary">
				<%--<select class="select" style="width: 300px;" id="departmentName"  name="departmentName" size="1" >
					<option value="0"> 请选择 </option>


				</select>--%>
			</div>
		</div>

		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">项目金额：</label>
			<div class="formControls col-xs-8 col-sm-9">

				<input type="text" style='border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' readonly class="input-text" value="￥${project.price}元" placeholder="" >
				<%--
				<select id="province_id" name="province_id" multiple="multiple" size="10" style="width: 150px;">
					<option value="0" selected="">选择人员</option>

				</select>--%>
			</div>
		</div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">分配人员：</label>
			<div class="formControls col-xs-8 col-sm-9">

				<input type="text" style='border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' readonly class="input-text" value="${project.member}" placeholder="" >
				<%--
				<select id="province_id" name="province_id" multiple="multiple" size="10" style="width: 150px;">
					<option value="0" selected="">选择人员</option>

				</select>--%>
			</div>
		</div>

		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">项目起始时间：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<%--<div id="tcPreview">
					</div>
				<input type="file" name="file" id="coverImg" onchange="previewImage(this,'tcPreview')" />--%><%--
					<input id="startTime" class="laydate-icon"><input id="endTime" class="laydate-icon">--%>
					<input type="text" readonly style='border-left:0px;border-top:0px;border-right:0px;border-bottom:1px;width: 100px ' class="input-text"  value="<fmt:formatDate value="${project.starttime}" pattern="yyyy-MM-dd" />" placeholder="" >——
					<input type="text"  readonly style='border-left:0px;border-top:0px;border-right:0px;border-bottom:1px;width: 100px ' class="input-text"  value="<fmt:formatDate value="${project.endtime}" pattern="yyyy-MM-dd" />" placeholder="" >
			</div>
		</div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-2">项目描述：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <%--<div id="tcPreview">
                    </div>
                <input type="file" name="file" id="coverImg" onchange="previewImage(this,'tcPreview')" />--%>
              <textarea id="contect" cols="45" style='overflow:auto; background-attachment: fixed; background-repeat: no-repeat; border-style: solid;
border-color: #FFFFFF' readonly rows="10">${project.contect}</textarea>

            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-2">项目进度：</label>
            <div class="formControls col-xs-8 col-sm-9">

                <input type="text"  class="input-text" style='border-left:0px;border-top:0px;border-right:0px;border-bottom:1px ' readonly style="width: 300px;" value="${project.progress}" placeholder="" id="progress" name="progress">
            </div>
        </div>
		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2">审核详情：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<table>
					<thead>
					 <tr>
						 <th>审核人</th>
						 <th>审核状态</th>
						 <th>审核备注</th>
					 </tr>
					</thead>
					<tbody>
					<c:forEach items="${projectAudits}" var="projectAudit">
						<tr >
							<td>${projectAudit.name}</td>
							<td><c:if test="${projectAudit.auditstate==1}">
								<span class="label label-success radius">	已同意 </span>
							</c:if>
								<c:if test="${projectAudit.auditstate==2}">
									<span class="label label-success radius">	已拒绝 </span>
								</c:if>
								<c:if test="${projectAudit.auditstate==0}">
									<span class="label radius" style="background-color:red">待审核</span>
								</c:if></td>

							<td>${projectAudit.remark}</td>
						</tr>

					</c:forEach>
					</tbody>
				</table>

			</div>
		</div>


		<div id="but" class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
				<%--<button onClick="article_save_submit()"  class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存并提交审核</button>
				--%><button onClick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;关闭&nbsp;&nbsp;</button>
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
<%--日期插件--%>
<script>
    laydate({
        elem: '#startTime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
        event: 'focus' //响应事件。如果没有传入event，则按照默认的click
    });
    laydate({
        elem: '#endTime', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
        event: 'focus' //响应事件。如果没有传入event，则按照默认的click
    });
</script>
<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript">
</script><!--/请在上方写此页面业务相关的脚本-->
</body>
</html>
