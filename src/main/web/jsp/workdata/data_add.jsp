<%--
  Created by IntelliJ IDEA.
  User: 82705
  Date: 2017/6/22
  Time: 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%=basePath%>css/layui.css"  media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
    <script src="<%=basePath%>js/jquery1.11.3.min.js"></script>
</head>
<style>
    form{
        margin-left: 20px;
        margin-right: 20px;
    }
    .layui-span-ment
    {
        width:70px;
        padding:0 10px;
        height:100%;
        font-size:14px;
        background-color:#d2d2d2;
        color:#fff;
        overflow:hidden;
        white-space:nowrap;
    !important;
    }
</style>
<script>


</script>
<body>



<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>工作日志</legend>
</fieldset>
<form class="layui-form layui-form-pane" action="">

    <div class="layui-form-item" id="pro1" >
        <div class="layui-inline">
            <label class="layui-form-label">选择任务</label>
            <div class="layui-input-inline">
                <select name="mission"  lay-search="" lay-filter="sele" >
                    <option value="">直接选择或搜索选择</option>
                    <c:forEach items="${map.list1}" var="project" varStatus="projectIndex">
                        <option value="${project.dataid}" title="${project.name}">${project.name}</option>
                    </c:forEach>
                    <c:forEach items="${map.list2}" var="projectmission" varStatus="projectIndex">
                        <option value="${projectmission.dataid}" title="${projectmission.name}">${projectmission.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
    </div>


    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">工作内容描述</label>
        <div class="layui-input-block">
            <textarea placeholder="请输入内容" name="context" id="cont" class="layui-textarea"></textarea>
        </div>
    </div>
    <%--<div class="layui-form-item layui-form-text">
        <label class="layui-form-label">编辑器</label>
        <div class="layui-input-block">
            <textarea class="layui-textarea layui-hide" name="content" lay-verify="content" id="LAY_demo_editor"></textarea>
        </div>
    </div>--%>
    <div class="layui-form-item">
        <div class="layui-input-block" id="btn">
            <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
        </div>
    </div>
</form>
<div id="div2"></div>
<script src="<%=basePath%>js/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>

    layui.use(['form', 'layedit', 'laydate'], function(){
        var form = layui.form()
            ,layer = layui.layer
            ,layedit = layui.layedit
            ,laydate = layui.laydate;

        //创建一个编辑器
        var editIndex = layedit.build('LAY_demo_editor');

        //自定义验证规则
        form.verify({
            title: function(value){
                if(value.length < 1){
                    return '标题不能为空';
                }
            }
            ,pass: [/(.+){6,12}$/, '密码必须6到12位']
            ,content: function(value){
                layedit.sync(editIndex);
            }
        });

        //选择项目
        var province_id ="";
        var province_name ="";

        form.on('select(sele)', function(data){
            province_id = data.value;
            province_name=data.elem[data.elem.selectedIndex].title;
        });

        //监听提交
        form.on('submit(demo1)', function(data){

            $("#btn").css({"display":"none"});
            var dataJson = {
                time:data.field.time,
                missiondataid:province_id,
                missionname:province_name,
                workcontext:data.field.context,
            };
            $.ajax({
                url : '<%=basePath%>addWorkdata',
                type : 'post',
                contentType : 'application/json;charset=utf-8',
                dataType : 'json',
                data : JSON.stringify(dataJson),
                success : function(data) {
                    if (data.success) {
                        layer.msg('添加日志成功' ,{time: 2000, icon:6});
                        $("#but").hide();
                    } else {
                        layer.msg('添加日志失败' ,{time: 2000, icon:5});

                    }
                }
            });
            return false;
        });
    });
</script>

</body>
</html>
