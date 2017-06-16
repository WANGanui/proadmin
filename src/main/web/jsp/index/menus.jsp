<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>

<link href="../css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="../js/jquery.js">
</script>

<script type="text/javascript">
$(function() {
	//全部展开
	$('dd').find('ul').slideDown();
	//导航切换
	$(".menuson li").click(function (){
		$(".menuson li.active").removeClass("active")
		$(this).addClass("active");
	});
	
	$('.title').click(function() {
		var $ul = $(this).next('ul');
		$('dd').find('ul').slideUp();
		if ($ul.is(':visible')) {
			$(this).next('ul').slideUp();
		} else {
			$(this).next('ul').slideDown();
		}
	});
})
</script>

<body style="background: #f0f9fd;">
	<div class="lefttop">
		<span></span>业务操作
	</div>

	<dl class="leftmenu">
		<%--<c:set var="one" value="0"></c:set>
		<c:forEach items="${menus}" var="menu">
			<!-- 一级菜单  -->
			<c:if test="${menu.modulePid==0}">
				<dd>
					<div class="title">
						<span><img src="../images/leftico01.png" /> </span>${menu.moduleName}
					</div>
					<!--  二级菜单  -->
					<ul class="menuson">
						<c:forEach items="${menus}" var="menutwo">
							<c:if test="${menutwo.modulePid==menu.moduleId}">
								<li >
									<cite></cite><a href="${menutwo.moduleUrl}" target="${menutwo.pageTarget!=null? 'blank' : 'rightFrame'}">${menutwo.moduleName}</a><i></i>
								</li>
								<c:set value="1" var="one"></c:set>
							</c:if>
						</c:forEach>
					</ul>
				</dd>
			</c:if>
		</c:forEach>--%>
	</dl>
</body>

