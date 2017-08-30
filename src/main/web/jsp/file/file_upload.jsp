<%--
  Created by IntelliJ IDEA.
  User: 82705
  Date: 2017/8/1
  Time: 10:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>附件上传</title>
    <link href="<%=basePath%>css/stream-v1.css" rel="stylesheet" type="text/css" />
    <link href="<%=basePath%>css/webuploader.css" rel="stylesheet" type="text/css" />

    <link rel="stylesheet" type="text/css" href="<%=basePath%>lib/Hui-iconfont/1.0.7/iconfont.css" />
    <script type="text/javascript" src="<%=basePath%>js/jquery-1.11.1.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/bootstrap-datepicker.ja.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/webuploader.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/webuploader.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>js/upload3.js"></script>
    <script type="text/javascript" src="<%=basePath%>lib/layer/2.1/layer.js"></script>
</head>
<body>
<%--<form enctype="multipart/form-data">
<div id="uploader" class="wu-example">
    <!--用来存放文件信息-->
    <div id="thelist1" class="uploader-list"></div>
    <div class="btns">
        <div id="multi" class="webuploader-container"><div class="webuploader-pick">点击选择文件</div>
            <div id="rt_rt_1blpo379fs1finkji111eoj4" style="position: absolute; top: 0px; left: 0px; width: 126px; height: 46px; overflow: hidden; bottom: auto; right: auto;">
                <input type="file" name="multiFile" class="webuploader-element-invisible" multiple="multiple">
                <label style="opacity: 0; width: 100%; height: 100%; display: block; cursor: pointer; background: rgb(255, 255, 255);"></label>
            </div>
        </div>
        <input type="button" value="上传" id="multiUpload">
    </div>
</div>
</form>--%>
<%--<input type="hidden" value="${mission.dataid}" id="missionid">
<c:forEach items="${file}" var="item">
        <div style="width: 250px;float: left;margin-left: 20px;">
            <i class="Hui-iconfont" style="font-size: 60px;">&#xe626;</i><br>
            <p>${item.nameold}</p><br>
            <a href="${item.path}" style="text-decoration: none">下载</a>
            <a style="text-decoration: none" onclick="picture_del('${item.dataid}')">删除</a>
        </div>

</c:forEach>--%>
<div id="uploader" class="wu-example">
    <%--<!--用来存放文件信息-->
    <div id="thelist" class="uploader-list"></div>
    <div class="btns">
        <div id="attach"></div>
        <input type="button" value="上传" id="upload"/>
    </div>--%>
</div>


<div id="uploader1" class="wu-example" style="position:absolute;margin-top: 300px;margin-left: 200px">
    <!--用来存放文件信息-->
    <div id="thelist1" class="uploader-list"></div>
    <div class="btns">
        <div id="multi"></div>
        <input type="button" value="上传" id="multiUpload"/>
    </div>
</div>
<script>

    function picture_del(id){
        layer.confirm('确认要删除吗？',function(){

            $.ajax( {
                url : '<%=basePath%>deleteFile?dataid='+id,
                type : 'post',
                contentType : 'application/json;charset=utf-8',
                dataType : 'json',
                success : function(data) {
                    if (data.success) {
                        location.replace(location.href)
                        layer.msg('已删除!',{icon:1,time:1000});
                    } else {
                        layer.msg('删除失败',{icon:1,time:1000});
                    }
                }
            });
        });
    }
    /*********************************WebUpload 单文件上传 begin*****************************************/
    $(function(){
        var $list = $("#thelist");
        var  uploader ;// 实例化
        var missionid = $("#missionid").val();
        uploader = WebUploader.create({
            auto:false, //是否自动上传
            pick: {
                id: '#attach',
                name:"file",  //这个地方 name 没什么用，虽然打开调试器，input的名字确实改过来了。但是提交到后台取不到文件。如果想自定义file的name属性，还是要和fileVal 配合使用。
                label: '点击选择图片',
                multiple:false            //默认为true，就是可以多选
            },
            swf: '../../js/Uploader.swf',
            fileVal:'multiFile',  //自定义file的name属性，我用的版本是0.1.5 ,打开客户端调试器发现生成的input 的name 没改过来。
            //名字还是默认的file,但不是没用哦。虽然客户端名字没改变，但是提交到到后台，是要用multiFile 这个对象来取文件的，用file 是取不到文件的
            // 建议作者有时间把这个地方改改啊，搞死人了。。
            server: "<%=basePath%>/uploadfile?missionid=",
            duplicate:true,//是否可重复选择同一文件
            resize: false,
            formData: {
                "status":"file",
                "contentsDto.contentsId":"0000004730",
                "uploadNum":"0000004730",
                "existFlg":'false'
            },
            compress: null,//图片不压缩
            chunked: false,  //分片处理
            //chunkSize: 5 * 1024 * 1024, //每片5M
            chunkRetry:false,//如果失败，则不重试
            threads:1,//上传并发数。允许同时最大上传进程数。
            // runtimeOrder: 'flash',
            // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
            disableGlobalDnd: true
        });

        // 当有文件添加进来的时候
        uploader.on( "fileQueued", function( file ) {
            console.log("fileQueued:");
            $list.append( "<div id='"+  file.id + "' class='item'>" +
                "<h4 class='info'>" + file.name + "</h4>" +
                "<p class='state'>等待上传...</p>" +
                "</div>" );
        });

        //当某个文件的分块在发送前触发
        uploader.on("uploadBeforeSend",function(object ,data){
            console.log("uploadBeforeSend");
            console.log(object);
            console.log(data);
        })

        //当所有文件上传结束时触发
        uploader.on("uploadFinished",function(){
            console.log("uploadFinished:");
        })

        //当某个文件上传到服务端响应后，会派送此事件来询问服务端响应是否有效。
        uploader.on("uploadAccept",function(object,ret){
            //服务器响应了
            //ret._raw  类似于 data
            var data =JSON.parse(ret._raw);
            if(data.resultCode != "1" && data.resultCode != "3"){
                if(data.resultCode == "9"){
                    uploader.reset();
                    alert("error");
                    return false;
                }
            }else{
                //E05017
                //uploader.reset();
                alert("error");
                return false;
            }
        })

        //当文件上传成功时触发。
        uploader.on( "uploadSuccess", function( file ) {
            $( "#"+file.id ).find("p.state").text("已上传");
        });

        uploader.on( "uploadError", function( file ) {
            $( "#"+file.id ).find("p.state").text("上传出错");
            uploader.cancelFile(file);
            uploader.removeFile(file,true);
            //uploader.reset();
        });


        $("#upload").on("click", function() {
            uploader.upload();
            alert("上传成功！");
        })

    });
    /*********************************WebUpload 单文件上传 end*******************************************/

    /*********************************WebUpload 多文件上传 begin*****************************************/
    $(function(){
        var $list = $("#thelist1");
        var fileSize = 0;  //总文件大小
        var fileName = []; //文件名列表
        var fileSizeOneByOne =[];//每个文件大小
        var uploader ;// 实例化
        var missionid = $("#missionid").val();
        uploader = WebUploader.create({
            auto:false, //是否自动上传
            pick: {
                id: '#multi',
                label: '点击选择文件',
                name:"file"
            },
            swf: '../../js/Uploader.swf',
            fileVal:'multiFile',              //和name属性配合使用
            server: "<%=basePath%>/uploadfile?missionid=",
            duplicate:true, //同一文件是否可重复选择
            resize: false,
            formData: {
                "status":"multi",
                "contentsDto.contentsId":"0000004730",
                "uploadNum":"0000004730",
                "existFlg":'false'
            },
            compress: null,//图片不压缩
            chunked: false,  //分片
            //chunkSize: 5 * 1024 * 1024,   //每片5M
            chunkRetry:false,//如果失败，则不重试
            threads:1,//上传并发数。允许同时最大上传进程数。
            //fileNumLimit:50,//验证文件总数量, 超出则不允许加入队列
            // runtimeOrder: 'flash',
            // 禁掉全局的拖拽功能。这样不会出现图片拖进页面的时候，把图片打开。
            disableGlobalDnd: true
        });

        // 当有文件添加进来的时候
        uploader.on( "fileQueued", function( file ) {
            console.log("fileQueued:");
            $list.append( "<div id='"+  file.id + "' class='item'>" +
                "<h4 class='info'>" + file.name + "</h4>" +
                "<p class='state'>等待上传...</p>" +
                "</div>" );
        });

        // 当开始上传流程时触发
        uploader.on( "startUpload", function() {
            console.log("startUpload");
            //添加额外的表单参数
            $.extend( true, uploader.options.formData, {"fileSize":fileSize,"multiFileName":fileName,"fileSizeOneByOne":fileSizeOneByOne});
        });

        //当某个文件上传到服务端响应后，会派送此事件来询问服务端响应是否有效。
        uploader.on("uploadAccept",function(object,ret){
            //服务器响应了
            //ret._raw  类似于 data
            console.log("uploadAccept");
            console.log(ret);
            var data =JSON.parse(ret._raw);
            if(data.resultCode!="1" && data.resultCode !="3"){
                if(data.resultCode == "9"){
                    alert("error");
                    uploader.reset();
                    return;
                }
            }else{
                uploader.reset();
                alert("error");
            }
        })

        uploader.on( "uploadSuccess", function( file ) {
            $( "#"+file.id ).find("p.state").text("已上传");
            window.location.reload();
        });

        //出错之后要把文件从队列中remove调，否则，文件还在队里中，还是会上传到后台去
        uploader.on( "uploadError", function( file,reason  ) {
            $( "#"+file.id ).find("p.state").text("上传出错");
            console.log("uploadError");
            console.log(file);
            console.log(reason);
            //多个文件
            var fileArray = uploader.getFiles();
            for(var i = 0 ;i<fileArray.length;i++){
                //取消文件上传
                uploader.cancelFile(fileArray[i]);
                //从队列中移除掉
                uploader.removeFile(fileArray[i],true);
            }
            //发生错误重置webupload,初始化变量
            uploader.reset();
            fileSize = 0;
            fileName = [];
            fileSizeOneByOne=[];
        });

        //当validate不通过时，会以派送错误事件的形式通知调用者
        uploader.on("error",function(){
            console.log("error");
            uploader.reset();
            fileSize = 0;
            fileName = [];
            fileSizeOneByOne=[];
            alert("error");
        })


        //如果是在模态框里的上传按钮，点击file的时候不会触发控件
        //修复model内部点击不会触发选择文件的BUG
        /*    $("#multi .webuploader-pick").click(function () {
         uploader.reset();
         fileSize = 0;
         fileName = [];
         fileSizeOneByOne=[];
         $("#multi :file").click();
         });*/

        /**
         * 多文件上传
         */
        $("#multiUpload").on("click",function(){
            uploader.upload();
            alert("上传成功！");
        })

        /**
         *取得每个文件的文件名和文件大小
         */
        //选择文件之后执行上传
        $(document).on("change","input[name='multiFile']", function() {
            //multiFileName
            var fileArray1 = uploader.getFiles();
            var fileNames = [];
            for(var i = 0 ;i<fileArray1.length;i++){
                fileNames.push(fileArray1[i].name); //input 框用
                //后台用
                fileSize +=fileArray1[i].size;
                fileSizeOneByOne.push(fileArray1[i].size);
                fileName.push(fileArray1[i].name);
            }
            console.log(fileSize);
            console.log(fileSizeOneByOne);
            console.log(fileName);
        })

    });

    /*********************************WebUpload 多文件上传 end*****************************************/

    /************************************webuploader的自带参数提交到后台的参数列表*************************
     * {

//web uploader 的自带参数
lastModifiedDate=[Wed Apr 27 2016 16:45:01 GMT+0800 (中国标准时间)],
chunks=[3], chunk=[0],
type=[audio/wav], uid=[yangl],  id=[WU_FILE_0],
size=[268620636], name=[3.wav],

//formData的参数
contentsDto.contentsId=[0000004730], existFlg=[false],
status=[file], uploadNum=[0000004730]
}

     可以用这个方法打印webuploader的自带参数列表，基本上就是上面的那一些
     //当某个文件的分块在发送前触发
     uploader.on("uploadBeforeSend",function(object ,data){
   console.log("uploadBeforeSend");
   console.log(object);
   console.log(data);
 })
     *********************************************************************************************/


</script>
</body>
</html>
