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
    <input type="hidden" value="${user.dataid}" name="dataid">
    <div class="layui-form-item">
        <label class="layui-form-label">员工姓名</label>
        <div class="layui-input-block">
            <input type="text" name="name" lay-verify="title" width="200"  autocomplete="off" value="${user.name}" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-block">
            <label class="layui-form-label">电话号码</label>
            <div class="layui-input-block">
                <input type="tel" name="phone" lay-verify="phone" value="${user.phone}" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">账号</label>
            <div class="layui-input-inline">
                <input type="tel" name="account" autocomplete="off" readonly value="${user.account}" class="layui-input">
            </div>
        </div>
    </div>


    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">选择部门</label>
            <div class="layui-input-inline">
                <select name="department" lay-verify="required" lay-search="" lay-filter="department">
                    <option value="${user.departmentdataid}" selected>${user.department}</option>
                    <c:forEach items="${map.daparts}" var="ment" varStatus="projectIndex">
                        <option value="${ment.dataid}" name="projectname" title="${ment.name}">${ment.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">选择角色</label>
            <div class="layui-input-inline">
                <select name="role" lay-verify="required" lay-search="" lay-filter="role">
                    <option value="${mmp.workerroleid}" selected>${mmp.workerrolename}</option>
                    <c:forEach items="${map.roles}" var="role" varStatus="projectIndex">
                        <option value="${role.dataid}" name="projectname">${role.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
    </div>

    <div class="layui-form-item" pane="">
        <label class="layui-form-label">状态</label>
        <div class="layui-input-block">
            <input type="checkbox" checked="" name="state" lay-skin="switch" lay-filter="switchTest" lay-text="启用|禁用">
        </div>
    </div>

    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <textarea placeholder="请输入内容" name="remark" class="layui-textarea">${user.remark}</textarea>
        </div>
    </div>
    <%--<div class="layui-form-item layui-form-text">
        <label class="layui-form-label">编辑器</label>
        <div class="layui-input-block">
            <textarea class="layui-textarea layui-hide" name="content" lay-verify="content" id="LAY_demo_editor"></textarea>
        </div>
    </div>--%>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="" lay-filter="demo1">确认修改</button>
            <button type="reset" class="layui-btn layui-btn-primary">重置</button>
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
            url : '<%=basePath%>selectUserList',
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
        //部门
        var departmentdataid = "";
        var department = "";
        form.on('select(department)', function(data){
            // alert(data.value+";"+data.elem[data.elem.selectedIndex].title);
            departmentdataid = data.value;
            department=data.elem[data.elem.selectedIndex].title;
        });
        //监听提交
        form.on('submit(demo1)', function(data){
            var dataJson = {
                dataid:data.field.dataid,
                name:data.field.name,
                phone:data.field.phone,
                roleid:data.field.role,
                state:data.field.state,
                departmentdataid:departmentdataid,
                department:department,
                remark:data.field.remark,
            };
            $.ajax( {
                url : '<%=basePath%>worker/updataWorker',
                type : 'post',
                contentType : 'application/json;charset=utf-8',
                dataType : 'json',
                data : JSON.stringify(dataJson),
                success : function(data) {
                    if (data.success) {
                        layer.confirm('修改员工成功', {
                            btn: ['确定'], //按钮
                        }, function(){
                            window.parent.location.reload();
                        });
                    } else {
                        layer.confirm('修改员工失败', {
                            btn: ['确定'], //按钮
                        }, function(){
                            layer.msg('修改员工失败' ,{time: 2000, icon:5});
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
