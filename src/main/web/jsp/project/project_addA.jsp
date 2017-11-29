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
				<select class="select" id="department" style="width: 300px;"  name="department" size="1" onchange="departmentUser()">
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
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>审核人部门：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<select id="province_ids" name="province_ids" multiple="multiple" size="10" style="width: 150px;" onchange="queryTwoBarand()">
					<option value="0" selected="">选择部门</option>
					<c:forEach items="${departmentList}" var="department">
						<option value="${department.dataid}">${department.name}</option>
					</c:forEach>
				</select>
<%--
				<select id="province_id" name="province_id" multiple="multiple" size="10" style="width: 150px;">
					<option value="0" selected="">选择人员</option>

				</select>--%>
			</div>
		</div>


		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>选择审核人：</label>
			<div class="formControls col-xs-8 col-sm-9">

				<select id="province_id" name="province_id" multiple="multiple" size="10" style="width: 150px;">
					<option value="0" selected="">选择审核人</option>

				</select>
			</div>
		</div>


		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>最终审核人：</label>
			<div class="formControls col-xs-8 col-sm-9">

				<select id="auditorid" name="auditorid" readonly="readonly" multiple="multiple" size="5" style="width: 150px;">

				</select>
			</div>
		</div>

		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>项目参与部门：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<select id="projectDept" name="projectDept" multiple="multiple" size="10" style="width: 150px;" onchange="queryTwoBarand()">
					<option value="0" selected="">选择部门</option>
					<c:forEach items="${departmentList}" var="department">
						<option value="${department.dataid}">${department.name}</option>
					</c:forEach>
				</select>
				<%--
                                <select id="province_id" name="province_id" multiple="multiple" size="10" style="width: 150px;">
                                    <option value="0" selected="">选择人员</option>

                                </select>--%>
			</div>
		</div>

		<div class="row cl">
			<label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>项目起始时间：</label>
			<div class="formControls col-xs-8 col-sm-9">
				<%--<div id="tcPreview">
					</div>
				<input type="file" name="file" id="coverImg" onchange="previewImage(this,'tcPreview')" />--%>
					<input id="startTime" class="laydate-icon">——<input id="endTime" class="laydate-icon">

			</div>
		</div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>项目描述：</label>
            <div class="formControls col-xs-8 col-sm-9">
                <%--<div id="tcPreview">
                    </div>
                <input type="file" name="file" id="coverImg" onchange="previewImage(this,'tcPreview')" />--%>
              <textarea id="contect" cols="45" rows="10"></textarea>

            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-xs-4 col-sm-2"><span class="c-red">*</span>项目进度：</label>
            <div class="formControls col-xs-8 col-sm-9">

                <input type="text"  class="input-text" style="width: 300px;" value="0%" placeholder="" id="progress" name="progress">
            </div>
        </div>


		<div id="but" class="row cl">
			<div class="col-xs-8 col-sm-9 col-xs-offset-4 col-sm-offset-2">
				<button onClick="article_save_submit()"  class="btn btn-primary radius" type="button"><i class="Hui-iconfont">&#xe632;</i> 保存并提交审核</button>
				<%--<button onClick="layer_close();" class="btn btn-default radius" type="button">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>
			--%></div>
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
function article_save(id,name){
	alert("1");
}
$("#province_id").click(function(){
    var opt=$("#province_id option:selected").val();
    if (opt==0){

	}else {
        var optname=$("#province_id option:selected").text();
        $("#auditorid").append("<option value='"+opt+"'>"+optname+"</option>");
	}
  //  $("#select_id option[value='3']").remove()
});
$("#auditorid").change(function(){
    var opt=$("#auditorid option:selected").val("删除");
    var checkIndex=$("#auditorid").get(0).selectedIndex;
   // alert(checkIndex);
    //$("#auditorid option[index='0']").val("删除");

     $("#auditorid option[value='删除']").remove();
});


/***
 * 项目负责人
 */
function departmentUser() {

    var province_ids = $("#department").val();
    var dataJson = {
        province_ids:province_ids
    };
    $.ajax({
        url: '<%=basePath%>selectUserListByDeptId',
        type: 'post',
        contentType: 'application/json;charset=utf-8',
        dataType: 'json',
        data: JSON.stringify(dataJson),
        success: function (data) {
            if (data.success) {
                var listCarBrand = data.workerList;
                var select = document.getElementById("departmentName");
                // document.write(listRole.length);
                //$("#carbrandPid").options.length=1;
                $("#departmentName").find("option").remove();
                select.options.add(new Option("请选择", 0));
                for (var i = 0; i < listCarBrand.length; i++) {

                    var id = listCarBrand[i].dataid;
                    var name = listCarBrand[i].name;
                    select.options.add(new Option(name, id));
                }
            } else {
            }
        }
    })
}
/**
 * 分配人员onchange事件
 */
function  queryTwoBarand() {

    var select = document.getElementById("province_ids");
    var province_ids="";
    //var province_ids="";
    for(i=0;i<select.length;i++){
        if(select.options[i].selected){
            if (province_ids==""){
                province_ids=select[i].value;
            }else{
                if(province_ids==0){
                    layer.msg('部门选择错误');
                    return false;
                }
                province_ids=province_ids+","+select[i].value;
            }
        }
    }
    var dataJson = {
        province_ids:province_ids
    };
	$.ajax( {
		url : '<%=basePath%>selectUserList',
		type : 'post',
		contentType : 'application/json;charset=utf-8',
		dataType : 'json',
		data : JSON.stringify(dataJson),
		success : function(data) {
			if (data.success) {
				var listCarBrand= data.workerList;
				var select = document.getElementById("province_id");
				// document.write(listRole.length);
				//$("#carbrandPid").options.length=1;
				$("#province_id").find("option").remove();
				select.options.add(new Option("请选择",0));
				for(var i = 0; i < listCarBrand.length; i++)
				{

					var id = listCarBrand[i].dataid;
					var name = listCarBrand[i].name;
					//select.options.add(new Option(name,id));
                    $("#province_id").append("<option value='"+id+"'>"+name+"</option>");
				}
			} else {
			}
		}
	});
}
function article_save_submit() {
    var contentTitle= $("#contentTitle").val();
	if (contentTitle.length==0){
		layer.msg('请输入项目名称' ,{time: 2000, icon:5});
		return false;
	}

	var departmentId=$("#departmentName").val();
    var departmentName=$("#departmentName").find("option:selected").text();
    if(departmentId==0){
		layer.msg('请选择负责人' ,{time: 2000, icon:5});
		return false;
	}
	var province_id_user=$("#province_id").val();
	if(province_id_user==0){
		layer.msg('请选择分配人员' ,{time: 2000, icon:5});
		return false;
	}
	var startTime=$("#startTime").val();
	if(startTime.length==0){
		layer.msg('请选择项目开始时间' ,{time: 2000, icon:5});
		return false;
	}
	var endTime=$("#endTime").val();
	if(endTime==0){
		layer.msg('请选择项目结束时间' ,{time: 2000, icon:5});
		return false;
	}
	var contect= $("#contect").val();
	if(contect.length==0){
		layer.msg('请输入项目描述' ,{time: 2000, icon:5});
		return false;
	};

	var progress=$("#progress").val();
	if (progress.length==0){
        layer.msg('请填写项目进度' ,{time: 2000, icon:5});
        return false;
    }

    var select = document.getElementById("projectDept");
    var projectDeptId="";
    for(i=0;i<select.length;i++){
        if(select.options[i].selected){
            if (projectDeptId==""){
                projectDeptId=select[i].value;

            }else{
                projectDeptId=projectDeptId+","+select[i].value;
            }
        }
    }
    var member="";
    var txt="";
    $("#auditorid option").each(function(){ //遍历全部option
	if (txt == ""){
        //获取option的内容

            txt= $(this).val();

	}else{
        //获取option的内容

            txt=txt+","+$(this).val();

	}


		 });
    if (txt==""){
        layer.msg('请选择审核人' ,{time: 2000, icon:5});
	}
    if (projectDeptId==""){
        layer.msg('请选择参与部门' ,{time: 2000, icon:5});
    }
    var dataJson = {
        name:contentTitle,//项目名称
        leaderid:departmentId,//项目负责人
        leader:departmentName,
        member:member,//分配人员
        starttime:startTime,//项目开始时间
        endtime:endTime,//项目结束时间
        contect:contect,//项目描述
        progress:progress,//项目 进度
        departmentid:projectDeptId,//参与部门
        auditorid:txt//审核人
    };
    $.ajax( {
        url : '<%=basePath%>addProject',
        type : 'post',
        contentType : 'application/json;charset=utf-8',
        dataType : 'json',
        data : JSON.stringify(dataJson),
        success : function(data) {

            if (data.success) {
                layer.msg('新建项目成功' ,{time: 2000, icon:6});
                $("#but").hide();
            } else {
                layer.msg('新建项目失败' ,{time: 2000, icon:5});

            }
        }
    });
}





</script><!--/请在上方写此页面业务相关的脚本-->
</body>
</html>