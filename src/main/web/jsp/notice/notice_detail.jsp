<%--
  Created by IntelliJ IDEA.
  User: 82705
  Date: 2017/6/22
  Time: 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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



<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>添加公告</legend>
</fieldset>
<form class="layui-form layui-form-pane" action="">
    <input type="hidden" value="${notice.dataid}" name="dataid">
    <div class="layui-form-item">
        <label class="layui-form-label">公告标题</label>
        <div class="layui-input-block">
            <input type="text" name="title" lay-verify="title" width="200" autocomplete="off" value="${notice.title}"   class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">发布日期</label>
            <div class="layui-input-inline">
                <input type="text" name="time"  id="date1" lay-verify="date"  autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})" value=<fmt:formatDate value="${notice.time}" pattern="yyyy-MM-dd" /> >
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">公告内容</label>
        <div class="layui-input-block">
            <textarea name="context"  class="layui-textarea">${notice.context} </textarea>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" id="btn" lay-submit="" lay-filter="demo1">确认修改</button>
        </div>
    </div>
</form>
<div id="div2"></div>
<script src="<%=basePath%>js/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>

    function  queryTwoBarand() {

        var select = document.getElementsByName("ment");
        var province_ids="";
        //var province_ids="";
        for(i=0;i<select.length;i++){
            if(select[i].checked){
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
            url : 'selectUserList',
            type : 'post',
            async:true,
            contentType : 'application/json;charset=utf-8',
            dataType : 'json',
            data : JSON.stringify(dataJson),
            success : function(data) {
                if (data.success) {
                    var listCarBrand= data.workerList;
                    var select = document.getElementById("province_id");
                    // document.write(listRole.length);
                    //$("#carbrandPid").options.length=1;
                    var htm="";
                    for(var i = 0; i < listCarBrand.length; i++)
                    {
                        var id = listCarBrand[i].dataid;
                        var name = listCarBrand[i].name;
                        htm+= "<input type=\"checkbox\" value="+id+" name=\"workername\" style=\"opacity: 1\" title="+name+">";

                    }
                    document.getElementById("province_id").innerHTML=htm;
                    var form = layui.form();
                    form.render("checkbox");
                } else {
                }
            }
        });
        return false;
    };
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
        form.on('button(set)',function () {

        });
        //监听提交
        form.on('submit(demo1)', function(data){
            $("#btn").css({"display":"none"});
            /*alert(JSON.stringify(data.field));*/
            $.ajax( {
                url : 'updateNotice',
                type : 'post',
                contentType : 'application/json;charset=utf-8',
                dataType : 'json',
                data : JSON.stringify(data.field),
                success : function(data) {
                    if (data.success) {
                        /*layer.msg('修改公告成功' ,{time: 2000, icon:6});*/
                        layer.confirm('修改公告成功', {
                            btn: ['确定'], //按钮
                        }, function(){
                            window.parent.location.reload();
                        });
                    } else {
                        layer.confirm('修改公告失败', {
                            btn: ['确定'], //按钮
                        }, function(){
                            layer.msg('修改公告失败' ,{time: 2000, icon:5});
                        });
                    }
                }
            });
            return false;
        });
    });
</script>

</body>
</html>
