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
    <script src="<%=basePath%>js/ajaxfileupload.js"></script>
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
    .notshow
    {
        width:50px;
        height: 50px;
        display: none;
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
                <option value="1" selected="">1级</option>
                <option value="2">2级</option>
                <option value="3">3级</option>
                <option value="4">4级</option>
                <option value="5">5级</option>
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
                <select name="header" lay-verify="required" lay-search="" lay-filter="header">
                    <option value="">直接选择或搜索选择</option>
                    <c:forEach items="${workers}" var="worker1" varStatus="projectIndex">
                        <option value="${worker1.dataid}" name="headername" title="${worker1.name}">${worker1.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
       <%-- <div class="layui-inline">
            <label class="layui-form-label">选择审核人</label>
            <div class="layui-input-inline">
                <select name="auditor" lay-verify="required" lay-search="" lay-filter="auditor">
                    <option value="">直接选择或搜索选择</option>
                    <c:forEach items="${workers}" var="worker2" varStatus="projectIndex">
                        <option value="${worker2.dataid}" name="auditorame" title="${worker2.name}">${worker2.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>--%>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label" style="width: auto" >审核人部门</label>
        <div class="layui-input-block" id="audit_ids">
            <c:forEach items="${partment}" var="item" varStatus="itemIndex1" >
                <input type="checkbox" class="layui-span-ment" name="menttt" value="${item.dataid}" title="${item.name}" >
            </c:forEach>
            <button class="layui-btn" id="moren" onclick="return queryTwoBarand2()">确认</button>

        </div>
    </div>

    <div class="layui-form-item" id="auditren" style="display: none">
        <label class="layui-form-label" style="width: auto">选择审核人</label>
        <div class="layui-input-block" id="audit_id">

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
            <select name="prodataid"  lay-search="" lay-filter="project">
                <option value="">直接选择或搜索选择</option>
                <c:forEach items="${list}" var="project" varStatus="projectIndex">
                    <option value="${project.dataid}" name="projectname" title="${project.name}">${project.name}</option>
                </c:forEach>
            </select>
        </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label" style="width:130px">项目任务阶段</label>
            <div class="layui-input-inline">
                <select name="level" multiple size="10"  >
                    <option value="" selected=""></option>
                    <option value="现场勘查">现场勘查</option>
                    <option value="设备实测">设备实测</option>
                    <option value="产品方案">产品方案</option>
                    <option value="投资收益分析">投资收益分析</option>
                    <option value="项目立项">项目立项</option>
                    <option value="项目实施方案">项目实施方案</option>
                    <option value="项目招投标">项目招投标</option>
                    <option value="项目合同签订">项目合同签订</option>
                    <option value="设备发货">设备发货</option>
                    <option value="设备交接">设备交接</option>
                    <option value="软件平台搭建">软件平台搭建</option>
                    <option value="项目验收">项目验收</option>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item" style="display: none" id="workerment" >
        <label class="layui-form-label" style="width: 130px;" >任务人员部门</label>
        <div class="layui-input-block" id="province_ids">
            <%--<c:forEach items="${partment}" var="item" varStatus="itemIndex1" >
                <input type="checkbox" class="layui-span-ment" name="ment" value="${item.dataid}" title="${item.name}" >
            </c:forEach>--%>

        </div>
    </div>
    <div class="layui-form-item" id="renyuan" style="display: none">
        <label class="layui-form-label">任务人员</label>
        <div class="layui-input-block" id="province_id">

        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: auto">选择任务状态</label>
            <div class="layui-input-inline">
                <select name="missionstate" lay-verify="required">
                    <option value="2" name="headername">待审核</option>
                   <%-- <option value="0" name="headername">已同意</option>
                    <option value="1" name="headername">已拒绝</option>--%>
                </select>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label" style="width: auto">选择流程状态</label>
            <div class="layui-input-inline">
                <select name="state" lay-verify="required" >
                    <option value="0" name="headername">未开始</option>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">任务进度</label>
        <div class="layui-input-block">
            <input type="text" name="percentage" lay-verify="title" width="200" autocomplete="off" value="0%" placeholder="" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">任务内容描述</label>
        <div class="layui-input-block">
             <textarea placeholder="请输入内容" name="context" class="layui-textarea"></textarea>
        </div>
    </div>
            <input type="file" name="file-demo" id="file" title="上传文件">
            <img src="<%=basePath%>/img/load.gif" class="notshow" id="loading"/>
             <input type="hidden" id="filename" name="filename" value="${obj.goodsPhoto}"/>

<%--<div class="layui-form-item layui-form-text">
        <label class="layui-form-label">编辑器</label>
        <div class="layui-input-block">
            <textarea class="layui-textarea layui-hide" name="content" lay-verify="content" id="LAY_demo_editor"></textarea>
        </div>
    </div>--%>
    <div class="layui-form-item">
        <div class="layui-input-block" id="but">
            <button class="layui-btn" lay-submit="" lay-filter="demo1">立即提交</button>
        </div>
    </div>


</form>
<div id="div2"></div>
<script src="<%=basePath%>js/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    $(function() {
        $(":file").change(function () {
            //加载图标
            $("#loading").ajaxStart(function (data) {
                $(this).show();
                $(this).prev().hide();
            }).ajaxComplete(function () {
                $(this).hide();
                $(this).prev().show()
            });

            $.ajaxFileUpload({
                url: '<%=basePath%>uploadfile',
                secureuri: false,
                fileElementId: 'file',
                dataType: 'json',
                success: function (data) {
                    if (data.success){
                        $("#photoImg").attr("src", data.imagePath);
                        $("#filename").val(data.imagePath);
                    }
                }
            })
            return false;
        });
    })
    function  queryTwoBarand2() {
        $("#auditren").css({"display":"block"});
        var select = document.getElementsByName("menttt");
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
                    var htm="";
                    for(var i = 0; i < listCarBrand.length; i++)
                    {
                        var id = listCarBrand[i].dataid;
                        var name = listCarBrand[i].name;
                        htm+= "<input type=\"checkbox\" value="+id+" name=\"auditname\" style=\"opacity: 1\" title="+name+">";

                    }
                    document.getElementById("audit_id").innerHTML=htm;
                    var form = layui.form();
                    form.render("checkbox");
                } else {
                }
            }
        });
        return false;
    };

    function  queryTwoBarand() {
        $("#renyuan").css({"display":"block"});
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
        var leaderid ="";
        var leader="";
        //任务负责人
        form.on('select(header)', function(data){
            // alert(data.value+";"+data.elem[data.elem.selectedIndex].title);
            leaderid = data.value;
            leader=data.elem[data.elem.selectedIndex].title;
        });
        //任务审核人
        var auditorid = "";
        var auditor = "";
        form.on('select(auditor)', function(data){
            // alert(data.value+";"+data.elem[data.elem.selectedIndex].title);
            auditorid = data.value;
            auditor=data.elem[data.elem.selectedIndex].title;
        });
        //选择项目
        var project ="";
        var projectid ="";
        form.on('select(project)', function(data){
            // alert(data.value+";"+data.elem[data.elem.selectedIndex].title);
            $("#province_id").removeClass();
            $("#workerment").css({"display":"block"})
            projectid = data.value;
            project=data.elem[data.elem.selectedIndex].title;
            $.ajax({
                url:'<%=basePath%>selectPartmentBypro?dataid='+projectid,
                type : 'post',
                contentType : 'application/json;charset=utf-8',
                dataType : 'json',
                success:function (data) {
                    if(data.success){
                        var listCarBrand= data.partmentList;
                        var htm="";
                        if (listCarBrand!=null){
                            $("#province_ids").css({"display":"block"});
                            for(var i = 0; i < listCarBrand.length; i++)
                            {
                                var id = listCarBrand[i].dataid;
                                var name = listCarBrand[i].name;
                                htm+= "<input type=\"checkbox\" value="+id+" name=\"ment\" style=\"opacity: 1\" title="+name+">";
                            }
                            document.getElementById("province_ids").innerHTML=htm+"<button class=\"layui-btn\" id=\"moren\" style='margin-left: 10px' onclick=\"return queryTwoBarand()\">确认</button>";
                            var form = layui.form();
                            form.render("checkbox");
                        }else {
                            $("#province_ids").css({"display":"none"});
                        }
                    }
                }
            })
        });
        //监听提交
        form.on('submit(demo1)', function(data){
           /* layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            })*/
            var select = document.getElementsByName("workername");
            var province_id="";
            var  province_name="";
            for(i=0;i<select.length;i++){
                if(select[i].checked){
                    if (province_id==""){
                        province_id=select[i].value;
                        province_name=select[i].title;
                    }else{
                        if(province_id==0){
                            layer.msg('人员选择错误');
                            return false;
                        }
                        province_id=province_id+","+select[i].value;
                        province_name=province_name+","+select[i].title;
                    }
                }
            }
            var select2 =document.getElementsByName("auditname");
            var audit_id="";
            var audit_name="";
            for (i=0;i<select2.length;i++){
                if (select2[i].checked){
                    if (audit_id==""){
                        audit_id=select2[i].value;
                        audit_name=select2[i].title;
                    }else {
                        if(audit_id==0){
                            layer.msg('人员选择错误');
                            return false;
                        }
                        audit_id=audit_id+","+select2[i].value;
                        audit_name=audit_name+","+select2[i].title;
                    }
                }
            }

            var audits=audit_id+"+"+audit_name;
            var member=province_id+"+"+province_name;

            var dataJson = {
                name:data.field.name,//任务名称
                proportion:data.field.proportion,//任务权重
                headerid:leaderid,//任务负责人
                headername:leader,
                auditorid:auditorid,//任务审核人
                auditorname:auditor,
                prodataid:projectid,//项目
                proname:project,
                member:member,//分配人员
                audits:audits,//审核人
                type:data.field.type,//任务类型
                starttime:data.field.starttime,//任务开始时间
                endtime:data.field.endtime,//任务结束时间
                level:data.field.level,//项目任务阶段
                context:data.field.context,//任务描述
                percentage:data.field.percentage,//任务 进度
                missionstate:data.field.missionstate,
                state:data.field.state,
                /*remark:data.field.remark,*/
            };
            $.ajax( {
                url : '<%=basePath%>addMission',
                type : 'post',
                contentType : 'application/json;charset=utf-8',
                dataType : 'json',
                data : JSON.stringify(dataJson),
                success : function(data) {
                    if (data.success) {
                        layer.msg('创建任务成功' ,{time: 2000, icon:6});
                        $("#but").hide();
                    } else {
                        layer.msg('创建任务失败' ,{time: 2000, icon:5});

                    }
                }
            });
            return false;
        });
    });
</script>

</body>
</html>
