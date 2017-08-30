<%--
  Created by IntelliJ IDEA.
  User: 82705
  Date: 2017/8/28
  Time: 11:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>--%>
<%
    String swfFilePath=session.getAttribute("swfFilePath").toString();
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>css/flexpaper.css">
    <script type="text/javascript" src="<%=basePath%>js/jquery.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/flexpaper_handlers.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/flexpaper_handlers_debug.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/flexpaper.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/flexpaper_flash.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/flexpaper_flash_debug.js"></script>
    <style type="text/css" media="screen">
        html,body{
            height: 100%;
        }
        body{
            margin: 0;
            padding: 0;
            overflow: auto;
        }
        #flashContent{
            display: none;
        }
    </style>
    <title>在线文档预览</title>
</head>
<body>
<div style="position: absolute;width: 100%;height: 100%;">
    <a id="viewerPlaceHolder" style="width: 100%;height: 100%;display: block;"></a>
    <script type="text/javascript">
        var fp=new FlexPaperViewer(
            '<%=basePath%>js/FlexPaperViewer',
            'viewerPlaceHolder',
            {
                config:{
                SwfFile:escape('${swfFilePath}'),
                Scale:1,
                ZoomTransition:'easeOut',
                ZoomTime:0.5,
                ZoomInterval:0.2,
                FitPageOnLoad:true,
                FitWidthOnload:false,
                FullScreenAsMaxWindow:false,
                ProgressiveLoading:false,
                MinZoomSize:0.2,
                MaxZoomSize:5,
                SearchMatchAll:false,
                InitViewMode:'SinglePage',
                RenderingOrder : 'flash',
                ViewModeToolsVisible:true,
                ZoomToolsVisible:true,
                NavToolsVisible:true,
                CursorToolsVisible:true,
                SearchToolsVisible:true,
                localeChain:'en_US'}
            });
    </script>
</div>
<%--<div id="documentViewer" class="flexpaper_viewer" style="position:absolute;left:0px;top:0px;width:100%;height:100%">loading document... </div>
<script type="text/javascript">
    $('#documentViewer').FlexPaperViewer(
        { config : {
            SWFFile : '<%=swfFilePath%>',
            Scale : 0.8,
            ZoomTransition : 'easeOut',
            ZoomTime : 0.5,
            ZoomInterval : 0.2,
            FitPageOnLoad : true,
            FitWidthOnLoad : false,
            FullScreenAsMaxWindow : false,
            ProgressiveLoading : false,
            MinZoomSize : 0.2,
            MaxZoomSize : 5,
            SearchMatchAll : false,
            InitViewMode : 'Portrait',
            RenderingOrder : 'flash',
            StartAtPage : '',

            ViewModeToolsVisible : true,
            ZoomToolsVisible : true,
            NavToolsVisible : true,
            CursorToolsVisible : true,
            SearchToolsVisible : true,
            jsDirectory:'<%=basePath%>js',//根据自己项目设置
            WMode : 'window',
            localeChain: 'en_US'

        }}
    );

</script>--%>
</body>
</html>
