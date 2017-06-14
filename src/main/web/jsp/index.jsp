<%--
  Created by IntelliJ IDEA.
  User: 82705
  Date: 2017/6/6
  Time: 14:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>主页</title>
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/webpro.index.css" />
    <link rel="stylesheet" href="<%=basePath%>css/lyz.calendar.css" />
    <link rel="stylesheet" href="<%=basePath%>css/messenger.css" />
    <link rel="stylesheet" href="<%=basePath%>css/messenger-theme-future.css" />
    <link rel="stylesheet" href="<%=basePath%>css/default/easyui.css"/>
    <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery1.11.3.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery.ui.core.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery.ui.widget.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery.ui.mouse.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery.ui.slider.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery.ui.draggable.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/lyz.calendar.min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/messenger.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/messenger-theme-future.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/doT.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/mock-min.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/webpro.debug.js" ></script>
    <script type="text/javascript" src="<%=basePath%>js/webpro.index.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery.easyui.min.js"></script>

<script>
    var data = ${initData};
    window.onload = function () {
        if(data.workerInfo == "" || data.workerInfo===undefined){
            Messenger.alertErr("请重新登录！");
        }
    }
</script>

</head>
<body>
<div class="view-header">
    <div class="view-header-title">
        <i class="fa fa-globe"></i><span class="txt">HRG项目管理系统</span>
    </div>

    <dic class="login-gourp btn-group">
        <div class="loginName dropdown-toggle" data-toggle="dropdown">
            <i class="fa fa-user"></i><span></span><i class="fa fa-angle-down"></i>
        </div>
        <ul class="dropdown-menu" role="menu">
            <li><a class="updateUserInfo" url="user_group/user_info_dialog.html">修改个人信息</a></li>
            <li><a class="updatePwd" url="/password">修改密码</a></li>

            <li class="divider"></li>
            <li><a href="<%=basePath%>worker/logout">注销</a></li>
        </ul>
    </dic>
</div>

<div class="view-body">
    <div class="view-body-menu">
        <div class="view-body-menu-control">
            <div class="menu-control-lv1">
            </div>
            <div class="menu-control-group" style="display: block;">
                <div class="menuLV2-lv2Item">
                    <div class="L2Header" id="h1">项目管理</div>
                    <div class="L3CC" id="l1" style="display: block;">
                        <div class="L3Item" code="13_9" aciton_url="/list"><i class="fa fa-file-text-o"></i>员工列表</div>
                        <div class="L3Item" code="13_8" aciton_url="{{=l3Item.aciton_url}}"><i class="fa fa-file-text-o"></i>阿斯蒂芬</div>
                        <div class="L3Item" code="13_9" aciton_url="{{=l3Item.aciton_url}}"><i class="fa fa-file-text-o"></i>水电费</div>
                        <div class="L3Item" code="13_8" aciton_url="{{=l3Item.aciton_url}}"><i class="fa fa-file-text-o"></i>阿斯蒂芬</div>
                    </div>
                </div>
                <div class="menuLV2-lv2Item">
                    <div class="L2Header">任务管理</div>
                    <div class="L3CC">
                        <div class="L3Item" code="13_9" aciton_url="{{=l3Item.aciton_url}}"><i class="fa fa-file-text-o"></i>东三省</div>
                        <div class="L3Item" code="13_8" aciton_url="{{=l3Item.aciton_url}}"><i class="fa fa-file-text-o"></i>a还能发货</div>
                        <div class="L3Item" code="13_9" aciton_url="{{=l3Item.aciton_url}}"><i class="fa fa-file-text-o"></i>水电费</div>
                        <div class="L3Item" code="13_8" aciton_url="{{=l3Item.aciton_url}}"><i class="fa fa-file-text-o"></i>阿斯蒂芬</div>
                    </div>
                </div>
                <div class="menuLV2-lv2Item">
                    <div class="L2Header">个人管理</div>
                    <div class="L3CC">
                        <div class="L3Item" code="13_9" aciton_url="{{=l3Item.aciton_url}}"><i class="fa fa-file-text-o"></i>安慰分为</div>
                        <div class="L3Item" code="13_8" aciton_url="{{=l3Item.aciton_url}}"><i class="fa fa-file-text-o"></i>羊肉汤</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="view-body-menu-split"><div class="split-btn"><i class="fa fa-caret-left"></i></div>	</div>
    </div>

    <div class="view-body-content">
        <ul class="breadcrumb">
            <li><i class="fa fa-home"></i><span>首页</span></li>
        </ul>
        <div class="content-iframe">
            <iframe frameborder="0" src=""></iframe>
            <div class="iframe-mask">
                <i class="fa fa-refresh fa-spin fa-3x fa-fw"></i>
            </div>
        </div>
    </div>
</div>

<div class="view-bottom"></div>

<div id="MaskDiv"></div>

<div class="mDialog">
    <div class="mDialog-title"><span></span><i class="fa fa-remove"></i></div>
    <div class="mDialog-body"><iframe frameborder="0"></iframe><div class="dragDiv"></div></div>
    <div class="mDialog-mask"><i class="fa fa-refresh fa-spin fa-2x fa-fw"></i></div>
</div>

<!--选表组件-->
<div class="selFromControl">
    <div class="body"><iframe frameborder="0"></iframe><div class="dragDiv"></div></div>
    <div class="mask"><i class="fa fa-refresh fa-spin fa-2x fa-fw"></i></div>
</div>
<script>
    var webpro=webpro(${initData},"");
</script>
</body>
</html>
