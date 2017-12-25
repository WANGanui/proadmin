<%@ page language="java" import="com.hrg.model.*"	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>" />	
<meta charset="utf-8">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<LINK rel="Bookmark" href="/favicon.ico" >
<LINK rel="Shortcut Icon" href="/favicon.ico" />
<!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<script type="text/javascript" src="lib/PIE_IE678.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.7/iconfont.css" />
<link rel="stylesheet" type="text/css" href="lib/icheck/icheck.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/style.css" />
<!--[if IE 6]>
<script type="text/javascript" src="http://lib.h-ui.net/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>HRG项目管理系统</title>
<meta name="keywords" content="">
<meta name="description" content="">
	<style>

		/*.chan_iframe iframe{
			height: 100%;
			width: 100%;
		}*/
		.chan_iframe{
			-webkit-overflow-scrolling: touch;
			overflow-y: scroll;
			/*position: fixed;*/
			!important;
		}
	</style>
</head>
<body>
<header class="navbar-wrapper">
	<div class="navbar navbar-fixed-top">
		<div class="container-fluid cl"> <a class="logo navbar-logo f-l mr-10 hidden-xs">HRG项目管理系统</a> <a class="logo navbar-logo-m f-l mr-10 visible-xs" href="/aboutHui.shtml">后台管理系统</a> <span class="logo navbar-slogan f-l mr-10 hidden-xs">v1.0</span> <a aria-hidden="false" class="nav-toggle Hui-iconfont visible-xs" href="javascript:;">&#xe667;</a>
			<nav class="nav navbar-nav">

			</nav>
			<nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
				<ul class="cl">
					<li>欢迎:</li>
					<li class="dropDown dropDown_hover"> <a href="javascript:;" class="dropDown_A">${worker.name} <i class="Hui-iconfont">&#xe6d5;</i></a>
						<ul class="dropDown-menu menu radius box-shadow">
							<%--<li><a href="#">个人信息</a></li>--%>
							<li><a href="javascript:;" onclick="updatePwe()">修改密码</a></li>
							<li><a href="worker/logout" target="_parent">退出</a></li>
						</ul>
					</li>
				<%--	<li id="Hui-msg"> <a href="#" title="消息"><span class="badge badge-danger">1</span><i class="Hui-iconfont" style="font-size:18px">&#xe68a;</i></a> </li>--%>
					<li id="Hui-skin" class="dropDown right dropDown_hover"> <a href="javascript:;" class="dropDown_A" title="换肤"><i class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>
						<ul class="dropDown-menu menu radius box-shadow">
							<li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>
							<li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
							<li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
							<li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
							<li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
							<li><a href="javascript:;" data-val="orange" title="绿色">橙色</a></li>
						</ul>
					</li>
				</ul>
			</nav>
		</div>
	</div>
</header>
<aside class="Hui-aside">
	<input runat="server" id="divScrollValue" type="hidden" value="" />
	<div class="menu_dropdown bk_2">

<c:forEach items="${map.menus}" var="menu">
	<c:if test="${menu.modulepid==0}">
		<dl id="menu-product">

				<dt <c:if test="${menu.datatid==5}">class="selected"</c:if>>
					<i class="Hui-iconfont">&#xe620;</i>
					      ${menu.modulename}
					  <i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i>
			  </dt>
				<dd  <c:if test="${menu.datatid==5}">style="display: block" </c:if>>
					<ul>
							<c:forEach items="${map.menus}" var="menutwo">
								 <c:if test="${menutwo.modulepid==menu.datatid}">
									    <li><a data-href="<%=basePath%>${menutwo.moduleurl}?roleid=${map.roleid}" onclick="_ssow()" data-title="${menutwo.modulename}" href="javascript:void(0)">${menutwo.modulename}${permissions.permissionid}
											<c:if test="${menutwo.datatid==19}">
												<c:if test="${map.auditmission!=0}"><span style="padding: 2px 7px;font-size: 12px;  background-color: red; border-radius: 30px; color: #fff;margin-left: 20px">${map.auditmission}</span></c:if>
											</c:if>
											<c:if test="${menutwo.datatid==20}">
												<c:if test="${map.auditproject!=0}"><span style="padding: 2px 7px; font-size: 12px; background-color: red; border-radius: 30px; color: #fff;margin-left: 20px">${map.auditproject}</span></c:if>
											</c:if>
											<c:if test="${menutwo.datatid==9}">
												<c:if test="${map.workermission!=0}"><span style="padding: 2px 7px; font-size: 12px; background-color: red; border-radius: 30px; color: #fff;margin-left: 20px">${map.workermission}</span></c:if>
											</c:if>
											<c:if test="${menutwo.datatid==7}">
												<c:if test="${map.workdata!=0}"><span style="padding: 2px 7px; font-size: 12px; background-color: red; border-radius: 30px; color: #fff;margin-left: 20px">${map.workdata}</span></c:if>
											</c:if>
											<c:if test="${menutwo.datatid==10}">
												<c:if test="${map.dataworker!=0}"><span style="padding: 2px 7px; font-size: 12px; background-color: red; border-radius: 30px; color: #fff;margin-left: 20px">${map.dataworker}</span></c:if>
											</c:if>
										</a>
										</li>
								 </c:if>
							</c:forEach>
					</ul>
				</dd>
		</dl>
	</c:if>
</c:forEach>

	</div>
</aside>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
	<div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
		<div class="Hui-tabNav-wp">
			<ul id="min_title_list" class="acrossTab cl">
				<li class="active"><span title="我的桌面" onclick="_ssow2()" data-href="/jsp/index/testJsp.jsp">我的桌面</span><em></em></li>
			</ul>
		</div>
		<div class="Hui-tabNav-more btn-group"><a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a><a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a></div>
	</div>
	<div id="iframe_box" class="Hui-article chan_iframe"  style="width: 100%">
		<div class="show_iframe chan_iframe" >
			<div style="display: none" class="loading"></div>
			<%--<iframe scrolling="yes" frameborder="0" src="<%=basePath%>worker/selectIndex?dataid=${worker.dataid}"></iframe>--%>
			<iframe scrolling="yes" frameborder="0"  src="<%=basePath%>worker/selectIndex?dataid=${worker.dataid}"></iframe>
		</div>
	</div>
	<%--<div id="iframe_box1"  style="width: 40%;margin-left: 60%;height: 720px;" >
		&lt;%&ndash;<div class="show_iframe"style="height: 720px;">
			&lt;%&ndash;<div style="display:none" class="loading"></div>
			<iframe scrolling="yes" frameborder="0" src="<%=basePath%>worker/selectIndex?dataid=${worker.dataid}"></iframe>
			<iframe scrolling="yes" frameborder="0" src="/jsp/index/demo2.jsp"></iframe>&ndash;%&gt;

		</div>&ndash;%&gt;
		<jsp:include page="demo2.jsp" flush="true"></jsp:include>
	</div>--%>
</section>
<%--
<div class="contextMenu" id="myMenu1">
	<ul>
		<li id="open">Open </li>
		<li id="email">email </li>
		<li id="save">save </li>
		<li id="delete">delete </li>
	</ul>
</div>--%>


<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="lib/layer/2.1/layer.js"></script> 
<script type="text/javascript" src="lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script> 
<script type="text/javascript" src="static/h-ui/js/H-ui.js"></script> 
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> 
<script type="text/javascript">
$(function(){
	$(".Hui-tabNav-wp").contextMenu('myMenu1', {
		bindings: {
			'open': function(t) {
				alert('Trigger was '+t.id+'\nAction was Open');
			},
			'email': function(t) {
				alert('Trigger was '+t.id+'\nAction was Email');
			},
			'save': function(t) {
				alert('Trigger was '+t.id+'\nAction was Save');
			},
			'delete': function(t) {
				alert('Trigger was '+t.id+'\nAction was Delete')
			}
		}
	});
});
	function updatePwe() {
		layer_show("修改密码","<%=basePath%>jsp/worker/password.jsp",400,300);
	}
	function _ssow() {
		$("#iframe_box1").css({"display":"none"});
        $("#iframe_box").css({"width":"100%"});
    }
function _ssow2() {
    $("#iframe_box1").css({"display":"block"});
}
</script> 

</body>
</html>