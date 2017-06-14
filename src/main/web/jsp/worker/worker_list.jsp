<%--
  Created by IntelliJ IDEA.
  User: 82705
  Date: 2017/6/9
  Time: 15:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="<%=basePath%>css/public.css" />
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.css" />
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap-theme.min.css" />
    <link href="<%=basePath%>css/font-awesome.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/default/easyui.css">
    <link rel="stylesheet" href="<%=basePath%>css/webpro.datalist.css" />

    <script type="text/javascript" src="<%=basePath%>js/jquery1.11.3.min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/lyz.calendar.min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery.validate.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>

    <script type="text/javascript" src="<%=basePath%>js/mock-min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/webpro.debug.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/easy.ui.1.5/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/doT.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/webpro.gridlist.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/webpro.debug.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/webpro.dialog.js"></script>


    <script id="funBtnsTmpl" type="text/x-dot-template">
        {{~it:value:i}}
        <button atTblTr="{{=value.attbltr}}" class="button button-rounded button-royal-flat"><i class="fa {{=value.icon}}"></i>{{=value.name}}</button>
        {{~}}
    </script>

</head>
<body>
<div class="panle-body">

    <div class="grid-searchBar">
        <form>
            <div class="queryItem">
                <div class="titTxt">名称</div><input id="name" name="name"  class="form-control input-sm" />
            </div>

            <div class="queryItem">
                <div class="titTxt">手机号码</div><input name="phone" class="form-control input-sm" />
            </div>

            <div class="queryItem">
                <div class="titTxt">状态</div><input name="state" class="form-control input-sm" />
            </div>

            <div class="queryItem">
                <div class="titTxt">部门</div><input name="department" class="form-control input-sm" />
            </div>

            <div class="button button-rounded button-royal-flat" id="testButtton">查询</div>

            <div style="clear: both;"></div>
        </form>
    </div>

    <div class="grid-bodyCenter">
        <div class="funBar"></div>

        <div class="gridPanle">
            <table id="dg" keyId="dataid" width="100%" height="100%">
                <thead>
                <tr>
                    <th data-options="field:'dataid',checkbox:true"></th>
                    <th data-options="field:'name',width:50">名称</th>
                    <th data-options="field:'account',width:50">账号</th>
                    <th data-options="field:'phone',width:50">手机号码</th>
                    <th data-options="field:'department',width:50">部门</th>
                    <th data-options="field:'state',width:50">状态</th>
                    <th data-options="field:'remark',width:50">备注</th>
                </tr>
                </thead>
            </table>
        </div>
    </div>
</div>
</body>
<script>
    console.info("服务注射的对象:",${data});

    WebPro_gridlistPage(window.parent,${data});
</script>
</html>
