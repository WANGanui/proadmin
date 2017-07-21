<!--_meta 作为公共模版分离出去-->
<%@ page language="java" import="java.util.*"	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>H+ 后台主题UI框架 - 首页示例二</title>
    <meta name="keywords" content="H+后台主题,后台bootstrap框架,会员中心主题,后台HTML,响应式后台">
    <meta name="description" content="H+是一个完全响应式，基于Bootstrap3最新版本开发的扁平化主题，她采用了主流的左右两栏式布局，使用了Html5+CSS3等现代技术">

    <link rel="shortcut icon" href="favicon.ico">
    <link href="<%=basePath%>css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="<%=basePath%>css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">

    <!-- Morris -->
    <link href="<%=basePath%>css/morris-0.4.3.min.css" rel="stylesheet">

    <!-- Gritter -->
    <link href="<%=basePath%>js/plugins/gritter/jquery.gritter.css" rel="stylesheet">

    <link href="<%=basePath%>css/animate.min.css" rel="stylesheet">
    <link href="<%=basePath%>css/style.min862f.css?v=4.1.0" rel="stylesheet">

    <script style="text/javascript">
        function picture_query(title,url){
            var index = layer.open({
                type: 2,
                title: title,
                content: url
            });
            layer.full(index);
        };
        function queryDetaila(id) {

            var index = layer.open({
                type: 2,
                title: "项目详情",
                content: "<%=basePath%>selectProjectDeatil?projectId="+id
            });
            layer.full(index);

        }
    </script>
</head>

<body class="gray-bg">

<div class="wrapper wrapper-content">
    <div class="row">
        <div class="col-sm-3">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <span class="label label-success pull-right">全年</span>
                    <h5>任务</h5>
                </div>
                <div class="ibox-content">
                    <h1 class="no-margins" ><a href="<%=basePath%>/missionList?roleid=${map.roleid}">${map.missionNum}</a></h1>
                    <div class="stat-percent font-bold text-success"><i class="fa fa-level-up"></i>
                    </div>
                    <small>数量</small>
                </div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <span class="label label-info pull-right">全年</span>
                    <h5>项目</h5>
                </div>
                <div class="ibox-content">
                    <h1 class="no-margins"><a  href="<%=basePath%>/projectList?roleid=${map.roleid}">${map.projectNum}</a></h1>
                    <div class="stat-percent font-bold text-info"><i class="fa fa-level-up"></i>
                    </div>
                    <small>数量</small>
                </div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <span class="label label-primary pull-right">当前</span>
                    <h5>待审核任务</h5>
                </div>
                <div class="ibox-content">
                    <h1 class="no-margins"><a  href="<%=basePath%>/missionCheck?roleid=${map.roleid}">${map.auditmission}</a></h1>
                    <div class="stat-percent font-bold text-navy"><i class="fa fa-level-up"></i>
                    </div>
                    <small>数量</small>
                </div>
            </div>
        </div>
        <div class="col-sm-3">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <span class="label label-danger pull-right">当前</span>
                    <h5>待审核项目</h5>
                </div>
                <div class="ibox-content">
                    <h1 class="no-margins"><a  href="<%=basePath%>/selectProjectAudit?roleid=${map.roleid}">${map.auditproject}</a></h1>
                    <div class="stat-percent font-bold text-danger"><i class="fa fa-level-up"></i>
                    </div>
                    <small>数量</small>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>业绩</h5>
                </div>
                <div class="ibox-content">
                    <div class="row" >
                        <div class="col-sm-9">
                            <div class="flot-chart" style="height: 270px">
                                <div class="flot-chart-content" id="row" style="width:152%;height: 320px;margin-top: -40px;margin-left: -60px"></div>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>


    <div class="row">
        <div class="col-sm-4">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>日志信息</h5>
                    <div class="ibox-tools">
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>
                        <a class="close-link">
                            <i class="fa fa-times"></i>
                        </a>
                    </div>
                </div>
                <%--<div class="ibox-content ibox-heading">
                    <h3><i class="fa fa-envelope-o"></i> 缺失日志</h3>
                </div>--%>
                <div class="ibox-content">
                    <table class="table table-hover no-margins">
                        <thead>
                        <tr>
                            <th>姓名</th>
                            <th>缺失日志(篇)</th>
                        </tr>
                        </thead>
                        <tbody  onclick="queryWorkData(${map.roleid})">
                        <c:forEach items="${map.workDataMissingLog}" var="notice">
                            <tr>
                               <td>${notice.name}</td>
                                <td class="text-navy"> ${notice.missingLog}</td>
                            </tr></c:forEach>
                        </tbody>
                    </table>
                   <%-- <div class="feed-activity-list">
                    <c:forEach items="${map.workDataMissingLog}" var="notice">
                        <div class="feed-element">
                            <div>
                                <strong>${notice.name}</strong>
                                <div>${notice.missingLog}</div>
                                    &lt;%&ndash;  <small class="text-muted"><fmt:formatDate value="${notice.time}"/></small>&ndash;%&gt;
                            </div>
                        </div>
                    </c:forEach>
                     </div>--%>
                </div>
            </div>
        </div>

        <div class="col-sm-8">
            <div class="row">
                <div class="col-sm-6">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>项目列表</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                                <a class="close-link">
                                    <i class="fa fa-times"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <table class="table table-hover no-margins">
                                <thead>
                                <tr>
                                    <th>状态</th>
                                    <th>日期</th>
                                    <th>项目</th>
                                    <th>进度</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${map.project}" var="projectAll">
                                <tr onclick="queryDetaila('${projectAll.dataid}')" >
                                    <td><small><c:if test="${projectAll.state==1}">
                                        <span class="label label-success radius">	审核完成 </span>
                                    </c:if>
                                        <c:if test="${projectAll.state==0}">
                                            <span class="label radius" style="background-color:red">	待审核</span>
                                        </c:if>

                                        <c:if test="${projectAll.state==2}">
                                            <span class="label radius" style="background-color: #9effff">	审核中</span>
                                        </c:if>
                                        <c:if test="${projectAll.state==3}">
                                            <span class="label radius" style="background-color: #bbbbbb">审核失败</span>
                                        </c:if></small>
                                    </td>
                                    <td><i class="fa fa-clock-o"></i><fmt:formatDate value="${projectAll.endtime}" pattern="yyyy-MM-dd" /></td>
                                    <td>${projectAll.name}</td>
                                    <td class="text-navy"> <i class="fa fa-level-up"></i> ${projectAll.progress}</td>
                                </tr></c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>任务列表</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                                <a class="close-link">
                                    <i class="fa fa-times"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content">
                            <table class="table table-hover no-margins">
                                <thead>
                                <tr>
                                    <th>状态</th>
                                    <th>日期</th>
                                    <th>任务</th>
                                    <th>进度</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${map.mission}" var="mission1">
                                    <tr onclick="picture_query('任务详情','<%=basePath%>missionDetail?dataid=${mission1.dataid}')">
                                        <td><small><c:if test="${mission1.state==0}">
                                            <span class="label label-success radius" style="background-color: #00a0e9">	未开始 </span>
                                        </c:if>
                                            <c:if test="${mission1.state==1}">
                                                <span class="label label-success radius" style="background-color: #13DAEC">进行中</span>
                                            </c:if>
                                            <c:if test="${mission1.state==2}">
                                                <span class="label label-success radius">已完成</span>
                                            </c:if></small>
                                        </td>
                                        <td><i class="fa fa-clock-o"></i><fmt:formatDate value="${mission1.endtime}" pattern="yyyy-MM-dd" /></td>
                                        <td >${mission1.name}</td>
                                        <td class="text-navy"> <i class="fa fa-level-up"></i> ${mission1.percentage}</td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <div class="ibox float-e-margins">
                        <div class="ibox-title">
                            <h5>业务地区</h5>
                            <div class="ibox-tools">
                                <a class="collapse-link">
                                    <i class="fa fa-chevron-up"></i>
                                </a>
                                <a class="close-link">
                                    <i class="fa fa-times"></i>
                                </a>
                            </div>
                        </div>
                        <div class="ibox-content">

                            <div class="row">
                                <div class="col-sm-6">
                                    <table class="table table-hover margin bottom">
                                        <thead>
                                        <tr>
                                            <th style="width: 1%" class="text-center">序号</th>
                                            <th>地区</th>
                                            <th class="text-center">日期</th>
                                            <th class="text-center">业务量</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr>
                                            <td class="text-center">1</td>
                                            <td>重庆
                                                </small>
                                            </td>
                                            <td class="text-center small">2017.9</td>
                                            <td class="text-center"><span class="label label-primary">483</span>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td class="text-center">2</td>
                                            <td>天津
                                            </td>
                                            <td class="text-center small">2017.9</td>
                                            <td class="text-center"><span class="label label-primary">327</span>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td class="text-center">3</td>
                                            <td>河南
                                            </td>
                                            <td class="text-center small">2017.9</td>
                                            <td class="text-center"><span class="label label-warning">125</span>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td class="text-center">4</td>
                                            <td>哈尔滨</td>
                                            <td class="text-center small">2017.9</td>
                                            <td class="text-center"><span class="label label-primary">344</span>
                                            </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                                <div class="col-sm-6">
                                    <div id="" style="height: 300px;">
                                        <jsp:include page="demo2.jsp"></jsp:include>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<!--公告提示-->
<c:if test="${map.noticeRelWorkTotal>0}">
<div id="small-chat">
    <span class="badge badge-warning pull-right" style="color: red;">${map.noticeRelWorkTotal}</span>
    <a class="open-small-chat">
        <i class="fa fa-comments"></i>
    </a>
</div>
<div class="small-chat-box fadeInRight animated active">

    <div class="heading" draggable="true">
       公告信息
    </div>

    <div class="slimScrollDiv" style="position: relative; width: auto; height: 234px;"><div class="content" style="width: auto; height: 234px;">
        <div class="left"><%--
            <c:forEach items="${map.relWorkMap}" var="relWorkMap">--%>
            <div class="author-name">
               ${map.relWorkMap.title}
                <input type="hidden" value="${map.relWorkMap.relWorkerId}"/>
            </div>
            <div class="chat-message active">
                    ${map.relWorkMap.context}
            </div><%--
            </c:forEach>--%>
        </div>



    </div><div class="slimScrollBar" style="background: rgb(0, 0, 0); width: 4px; position: absolute; top: 0px; opacity: 0.4; display: none; border-radius: 7px; z-index: 99; right: 1px; height: 120.608px;"></div><div class="slimScrollRail" style="width: 4px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; background: rgb(51, 51, 51); opacity: 0.4; z-index: 90; right: 1px;"></div></div>
    <div class="form-chat">
        <div class="input-group input-group-sm">
           <%-- <span class="input-group-btn"> <button class="btn btn-primary" onclick="read()" type="button">已阅
                </button> </span>--%>
            <span class="input-group-btn"> <button class="btn btn-primary" onclick="openUrl(${map.roleid})" type="button">更多公告......
                </button> </span>
        </div>
    </div>
</div>
</c:if>
<script type="text/javascript" src="<%=basePath%>js/jquery1.11.3.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/echarts.js"></script>
<script type="text/javascript" src="<%=basePath%>js/echarts.common.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/echarts.simple.min.js"></script>
<script type="text/javascript" src="<%=basePath%>js/echarts.min.js"></script>
<script src="<%=basePath%>js/jquery.min.js?v=2.1.4"></script>
<script src="<%=basePath%>js/bootstrap.min.js?v=3.3.6"></script>
<script src="<%=basePath%>js/plugins/flot/jquery.flot.js"></script>
<script src="<%=basePath%>js/plugins/flot/jquery.flot.tooltip.min.js"></script>
<script src="<%=basePath%>js/plugins/flot/jquery.flot.spline.js"></script>
<script src="<%=basePath%>js/plugins/flot/jquery.flot.resize.js"></script>
<script src="<%=basePath%>js/plugins/flot/jquery.flot.pie.js"></script>
<script src="<%=basePath%>js/plugins/flot/jquery.flot.symbol.js"></script>
<script src="<%=basePath%>js/plugins/peity/jquery.peity.min.js"></script>
<script src="<%=basePath%>js/demo/peity-demo.min.js"></script>
<script src="<%=basePath%>js/content.min.js?v=1.0.0"></script>
<script src="<%=basePath%>js/plugins/jquery-ui/jquery-ui.min.js"></script>
<script src="<%=basePath%>js/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js"></script>
<script src="<%=basePath%>js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>
<script src="<%=basePath%>js/plugins/easypiechart/jquery.easypiechart.js"></script>
<script src="<%=basePath%>js/plugins/sparkline/jquery.sparkline.min.js"></script>
<script src="<%=basePath%>js/demo/sparkline-demo.min.js"></script>
<script type="text/javascript" src="<%=basePath%>lib/layer/2.1/layer.js"></script>
<script>
    function queryWorkData(roleId) {
        if (roleId==3){
            var index = layer.open({
                type: 2,
                title:"日志列表",
                content: "<%=basePath%>missionWorkdata?roleid=3"
            });
            layer.full(index);
            //window.location.href='http://192.168.100.88:9090//missionWorkdata?roleid=3'
        }else if (roleId==2){
            var index = layer.open({
                type: 2,
                title:"个人日志",
                content: "<%=basePath%>workerdata?roleid=2"
            });
            layer.full(index);
            //window.location.href='http://192.168.100.88:9090//missionWorkdata?roleid=3'
        }

    }

    function openUrl(roleId) {
        var index = layer.open({
            type: 2,
            title:"公告列表",
            content: "<%=basePath%>noticeList?roleid="+roleId
        });
        layer.full(index);
    }
</script>
<script>

    var dataAxis = [];
    var data = [];
    $.ajax({
        url:"<%=basePath%>worker/selectyeji",
        type : 'post',
        async:true,
        contentType : 'application/json;charset=utf-8',
        dataType : 'json',
        success:function (data1) {
            if(data1.success){
                var yeji = data1.yejiList;
                for (var i = 0; i < yeji.length; i++){
                    var name=yeji[i].name;
                    dataAxis.push(name);
                    var  count=yeji[i].count;
                    data.push(count);

                }
                var myChart = echarts.init(document.getElementById('row'));
                var yMax = 50;
                var dataShadow = [];

                for (var i = 0; i < data.length; i++) {
                    dataShadow.push(yMax);
                }
                option = {
                    xAxis: {
                        data: dataAxis,
                        axisLabel: {
                            inside: true,
                            textStyle: {
                                color: '#ed5565'
                            }
                        },
                        axisTick: {
                            show: false
                        },
                        axisLine: {
                            show: false
                        },
                        z: 10
                    },
                    yAxis: {
                        axisLine: {
                            show: false
                        },
                        axisTick: {
                            show: false
                        },
                        axisLabel: {
                            textStyle: {
                                color: '#999'
                            }
                        }
                    },
                    dataZoom: [
                        {
                            type: 'inside'
                        }
                    ],
                    series: [
                        { // For shadow
                            type: 'bar',
                            itemStyle: {
                                normal: {color: 'rgba(0,0,0,0.05)'}
                            },
                            barGap:'-100%',
                            barCategoryGap:'40%',
                            data: dataShadow,
                            animation: false
                        },
                        {
                            type: 'bar',
                            itemStyle: {
                                normal: {
                                    color: new echarts.graphic.LinearGradient(
                                        0, 0, 0, 1,
                                        [
                                            {offset: 0, color: '#1ab394'},
                                            {offset: 0.5, color: '#1ab394'},
                                            {offset: 1, color: '#1ab394'}
                                        ]
                                    )
                                },
                                emphasis: {
                                    color: new echarts.graphic.LinearGradient(
                                        0, 0, 0, 1,
                                        [
                                            {offset: 0, color: '#1ab394'},
                                            {offset: 0.7, color: '#1ab394'},
                                            {offset: 1, color: '#1ab394'}
                                        ]
                                    )
                                }
                            },
                            data: data
                        }
                    ]
                };

                // Enable data zoom when user click bar.
                var zoomSize = 6;
                myChart.on('click', function (params) {
                    console.log(dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)]);
                    myChart.dispatchAction({
                        type: 'dataZoom',
                        startValue: dataAxis[Math.max(params.dataIndex - zoomSize / 2, 0)],
                        endValue: dataAxis[Math.min(params.dataIndex + zoomSize / 2, data.length - 1)]
                    });
                });

                myChart.setOption(option);
            }

        }
    });
</script>
<script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8">

</script>
</body>
</html>