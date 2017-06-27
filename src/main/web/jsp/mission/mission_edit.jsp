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
    <legend>修改任务</legend>
</fieldset>

<form class="layui-form layui-form-pane" action="">
    <div class="layui-form-item">
        <label class="layui-form-label">任务名称</label>
        <div class="layui-input-block">
            <input type="text" name="name" lay-verify="title" width="200" autocomplete="off" value="${map.mission.name}" disabled class="layui-input">
        </div>
    </div>
    <input type="hidden" value="${map.mission.dataid}" name="dataid">
    <div class="layui-form-item">
        <label class="layui-form-label">任务权重</label>
        <div class="layui-input-block">
            <select name="proportion" lay-filter="aihao">
                <option value="${map.mission.proportion}" selected="">${map.mission.proportion}级</option>
                <option value="1">1级</option>
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
            <input type="text" name="starttime"  id="date" lay-verify="date" autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})" value=<fmt:formatDate value="${map.mission.starttime}" pattern="yyyy-MM-dd" /> >
        </div>
    </div>
    <div class="layui-inline">
        <label class="layui-form-label">结束日期</label>
        <div class="layui-input-inline">
            <input type="text" name="endtime"  id="date1" lay-verify="date"  autocomplete="off" class="layui-input" onclick="layui.laydate({elem: this})" value=<fmt:formatDate value="${map.mission.endtime}" pattern="yyyy-MM-dd" /> >
        </div>
    </div>
</div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">选择责任人</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" disabled value="${map.mission.headername}">
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label">选择审核人</label>
            <div class="layui-input-inline">
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" disabled value="${map.mission.auditorname}">
                </div>
            </div>
        </div>
    </div>

    <div class="layui-form-item " pane="">
        <label class="layui-form-label">任务类型</label>
        <div class="layui-input-block" onclick="_change()">

            <c:if test="${map.mission.type==0}">
                <input type="radio" name="type" value="0" title="项目任务" checked="checked">
            </c:if>
            <c:if test="${map.mission.type==1}">
                <input type="radio" name="type" value="1" title="个人任务" checked="checked">
            </c:if>
        </div>
    </div>

    <c:if test="${map.mission.proname!=''}">
        <div class="layui-form-item" id="pro1" >
            <div class="layui-inline">
                <label class="layui-form-label">选择项目</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" disabled value="${map.mission.proname}">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label" style="width:130px">项目任务阶段</label>
                <div class="layui-input-inline">
                    <input type="text" class="layui-input" disabled value="${map.mission.level}">
                </div>
            </div>
        </div>
    </c:if>

    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 130px" >任务人员部门</label>
        <div class="layui-input-block" id="province_ids">
            <c:forEach items="${map.partment}" var="item" varStatus="itemIndex1" >
                <input type="checkbox" class="layui-span-ment" name="ment" value="${item.dataid}" title="${item.name}" >
            </c:forEach>
            <button class="layui-btn" id="moren" onclick="return queryTwoBarand()">确认</button>

        </div>
    </div>

    <div class="layui-form-item" id="renyuan" style="display: none">
        <label class="layui-form-label" style="width: 130px">添加任务人员</label>
        <div class="layui-input-block" id="province_id">

        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 130px">已选择任务人员</label>
        <div class="layui-input-block" id="province">
            <c:forEach items="${map.relworker}" var="work">
                <input type="checkbox" name="workername" value="${work.workerdataid}" title="${work.workername}" checked>
            </c:forEach>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 120px">选择任务状态</label>
            <div class="layui-input-inline">
                <c:if test="${map.mission.missionstate==0}">
                    <input type="text" class="layui-input" disabled value="已同意">
                </c:if>
                <c:if test="${map.mission.missionstate==1}">
                    <input type="text" class="layui-input" disabled value="已拒绝">
                </c:if>
                <c:if test="${map.mission.missionstate==2}">
                    <input type="text" class="layui-input" disabled value="待审核">
                </c:if>
            </div>
        </div>
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 120px">选择流程状态</label>
            <div class="layui-input-inline">
                <c:if test="${map.mission.state==0}">
                    <input type="text" class="layui-input" disabled value="未开始">
                </c:if>
                <c:if test="${map.mission.state==1}">
                    <input type="text" class="layui-input" disabled value="进行中">
                </c:if>
                <c:if test="${map.mission.state==2}">
                    <input type="text" class="layui-input" disabled value="已完成">
                </c:if>
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">任务进度</label>
        <div class="layui-input-block">
            <input type="text" name="percentage" lay-verify="title" width="200" autocomplete="off" value="${map.mission.percentage}" placeholder="" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">任务内容描述</label>
        <div class="layui-input-block">
            <textarea name="context" class="layui-textarea">${map.mission.context}</textarea>
        </div>
    </div>
    <div class="layui-form-item layui-form-text">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <textarea  name="remark"  class="layui-textarea" disabled>${map.mission.remark}</textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block" id="but">
            <button class="layui-btn" lay-submit="" lay-filter="demo1">确认修改</button>
        </div>
    </div>
</form>
<div id="div2"></div>
<script src="<%=basePath%>js/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
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
        var leaderid ="";
        var leader="";
       /* //任务负责人
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
            projectid = data.value;
            project=data.elem[data.elem.selectedIndex].title;
        });*/
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
            var member=province_id+"+"+province_name;

            var dataJson = {
                dataid:data.field.dataid,//任务名称
                proportion:data.field.proportion,//任务权重
                member:member,//分配人员
                context:data.field.context,//任务描述
                percentage:data.field.percentage,//任务 进度
                starttime:data.field.starttime,//任务开始时间
                endtime:data.field.endtime,//任务结束时间
                type:data.field.type,//任务类型
                remark:data.field.remark,
            };
            /*alert(JSON.stringify(dataJson));*/
            $.ajax( {
                url : 'updateMission',
                type : 'post',
                contentType : 'application/json;charset=utf-8',
                dataType : 'json',
                data : JSON.stringify(dataJson),
                success : function(data) {
                    if (data.success) {
                        layer.confirm('修改任务成功', {
                            btn: ['确定'], //按钮
                        }, function(){
                            window.parent.location.reload();
                        });
                    } else {
                        layer.confirm('修改任务失败', {
                            btn: ['确定'], //按钮
                        }, function(){
                            window.parent.location.reload();
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
