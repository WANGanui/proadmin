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



<fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
    <legend>新增任务</legend>
</fieldset>
<form class="layui-form layui-form-pane" action="">
    <div class="layui-form-item">
        <label class="layui-form-label">任务名称</label>
        <div class="layui-input-block">
            <input type="text" name="name" lay-verify="title" width="200" autocomplete="off"  placeholder="请输入标题" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">任务权重</label>
        <div class="layui-input-block">
            <select name="proportion" lay-filter="aihao">
                <option value=""></option>
                <option value="0" selected="">1级</option>
                <option value="1">2级</option>
                <option value="2">3级</option>
                <option value="3">4级</option>
                <option value="4">5级</option>
            </select>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">开始日期</label>
            <div class="layui-input-inline">
                <input type="text" name="starttime" id="date" lay-verify="date" placeholder="年-月-日" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">结束日期</label>
            <div class="layui-input-inline">
                <input type="text" name="endtime" id="date1" lay-verify="date" placeholder="年-月-日" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">选择责任人</label>
            <div class="layui-input-inline">
                <select name="headerid" lay-verify="required" lay-search="">
                    <option value="">直接选择或搜索选择</option>
                    <c:forEach items="${workers}" var="worker1" varStatus="projectIndex">
                        <option value="${worker1.dataid}" name="projectname">${worker1.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">选择审核人</label>
            <div class="layui-input-inline">
                <select name="auditorid" lay-verify="required" lay-search="">
                    <option value="">直接选择或搜索选择</option>
                    <c:forEach items="${workers}" var="worker2" varStatus="projectIndex">
                        <option value="${worker2.dataid}" name="projectname">${worker2.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
    </div>

    <div class="layui-form-item " pane="">
        <label class="layui-form-label">任务类型</label>
        <div class="layui-input-block" onclick="_change()">
            <input type="radio" name="type" value="1" change="show1()" title="个人任务" checked="">
            <input type="radio" name="type" value="0" change="show2()" title="项目任务">
        </div>
    </div>

    <div class="layui-form-item" id="pro1"  style="display: none">
        <div class="layui-inline">
        <label class="layui-form-label">选择项目</label>
        <div class="layui-input-inline">
            <select name="prodataid"  lay-search="">
                <option value="">直接选择或搜索选择</option>
                <c:forEach items="${list}" var="project" varStatus="projectIndex">
                    <option value="${project.name}" name="projectname">${project.name}</option>
                </c:forEach>
            </select>
        </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label" style="width:130px">项目任务阶段</label>
            <div class="layui-input-inline">
                <select name="level" multiple size="10" lay-verify="required" >
                    <option value=""></option>
                    <option value="1" selected="">现场勘查</option>
                    <option value="2">设备实测</option>
                    <option value="3">产品方案</option>
                    <option value="4">投资收益分析</option>
                    <option value="4">项目立项</option>
                    <option value="4">项目实施方案</option>
                    <option value="4">项目招投标</option>
                    <option value="4">项目合同签订</option>
                    <option value="4">设备发货</option>
                    <option value="4">设备交接</option>
                    <option value="4">软件平台搭建</option>
                    <option value="4">项目验收</option>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 130px">任务人员部门</label>
        <div class="layui-input-block" id="province_ids">
            <c:forEach items="${partment}" var="item" varStatus="itemIndex1" >
                <input type="checkbox" class="layui-span-ment" name="ment" value="${item.dataid}" title="${item.name}" >
            </c:forEach>
                <button class="layui-btn" id="moren" onclick="return queryTwoBarand()">确认</button>

        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">任务人员</label>
        <div class="layui-input-block" id="province_id">

        </div>
    </div>

    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">任务内容描述</label>
        <div class="layui-input-block">
            <textarea placeholder="请输入内容" name="context" class="layui-textarea"></textarea>
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
            <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
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
        //监听提交
        form.on('submit(demo1)', function(data){
            layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            })
            return false;
        });
    });
</script>

</body>
</html>
