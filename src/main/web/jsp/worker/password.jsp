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

    function _change() {
        var count = $("input:radio:checked").val();
        if(count==0){
            $("#pro1").css({"display":"block"});
        }else {
            $("#pro1").css({"display":"none"});
        }
    };
</script>
<body>



<form class="layui-form layui-form-pane" action="">
    <div class="layui-form-item">
        <label class="layui-form-label">原密码</label>
        <div class="layui-input-block">
            <input type="text" name="password" lay-verify="pass" width="200" autocomplete="off"  placeholder="请输入原密码" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-block">
            <label class="layui-form-label">新密码</label>
            <div class="layui-input-block">
                <input type="text" name="newPassword" lay-verify="pass" placeholder="请输入新密码"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-block">
            <label class="layui-form-label">确认新密码</label>
            <div class="layui-input-block">
                <input type="text" name="newPassword1" lay-verify="pass" placeholder="确认新密码"  autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
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
            }
        });

        //监听提交
        form.on('submit(demo1)', function(data){
            var newPassword = data.field.newPassword;
            var newPassword1 = data.field.newPassword1;
            if (newPassword1 != newPassword){
                layer.msg('两次输入的新密码不一样' ,{time: 2000, icon:6});
            }else {
                $.ajax( {
                    url : '<%=basePath%>worker/editPass',
                    type : 'post',
                    contentType : 'application/json;charset=utf-8',
                    dataType : 'json',
                    data : JSON.stringify(data.field),
                    success : function(data) {
                        if (data.success) {
                            layer.msg('修改密码成功' ,{time: 2000, icon:6});
                            $("#but").hide();
                        } else {
                            layer.msg('修改密码失败' ,{time: 2000, icon:5});
                        }
                    }
                });
            }
            return false;
        });
    });
</script>

</body>
</html>
