<%--
  Created by IntelliJ IDEA.
  User: 82705
  Date: 2017/6/5
  Time: 15:22
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
    <title>Title</title>
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/public.css" />
    <link rel="stylesheet" href="<%=basePath%>css/font-awesome.min.css">
    <link rel="stylesheet" href="<%=basePath%>css/messenger.css" />
    <link rel="stylesheet" href="<%=basePath%>css/messenger-theme-future.css" />
    <link rel="stylesheet" href="<%=basePath%>css/webpro.login.css" />
    <link rel="stylesheet" href="<%=basePath%>css/animate.css">


    <script src="<%=basePath%>js/jquery1.11.3.min.js"></script>
    <script src="<%=basePath%>js/bootstrap.min.js"></script>
    <script src="<%=basePath%>js/messenger.js"></script>
    <script src="<%=basePath%>js/messenger-theme-future.js"></script>
    <script src="<%=basePath%>js/mock-min.js"></script>
    <script>
        function WebPro(initData){
            Messenger.options = {
                extraClasses: 'messenger-fixed messenger-on-bottom messenger-on-right',
                theme: 'future'
            };

            $("#loginBtn").click(function(){
                Messenger().hideAll();

                if ($("#tbxName").val() == "") {
                    Messenger().alertErr("请输入用户名！");
                    return ;
                }
                if ($("#tbxPwd").val() == "") {
                    Messenger().alertErr("请输入用户密码！");
                    return ;
                }

                var url =initData.validateLoginUrl;
                console.warn("进来了",url);
                $.post(url,{
                    signName : $("#signName").val(),
                    passWord : $("#tbxPwd").val()
                },function(data){
                    console.info("返回数据",data);
                    if(data.status == 200){
                        window.location.href=initData.gotoIndexUrl;
                    }else{
                        Messenger().alertErr(data.msg);
                    }
                },"json");
            });

            /*document.onkeydown = function (e) {
             var ev = document.all ? window.event : e;
             if (ev.keyCode == 13) {
             $("#loginBtn").click();
             }
             }*/

        }
    </script>
</head>
<body>
<div class="login-top">
    <div class="title">
        			<span class="title-txt">
        				<i class="fa fa-globe"></i>HRG项目管理系统
        			</span>
        <br>
        <span>欢迎登录</span>
    </div>
</div>

<div class="login-form animated rotateIn">
    <div class="form-inner" id="loginInfo">
        <div class="form-group relative">
            <div class="input-group">
                <span class="input-group-addon input_icon"><i class="fa fa-envelope"></i></span>
                <input class="form-control input-lg typeahead-email" placeholder="账号" type="text" name="tbxName" id="signName"/>
            </div>
            <span class="inputTips email_inputTips"></span>
        </div>
        <div class="form-group relative">
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-key"></i></span>
                <input class="form-control input-lg" placeholder="密码" type="password" id="tbxPwd" />
            </div>
            <span class="inputTips pwd_inputTips"></span>
        </div>
        <div class="form-group">
            <!--<div class="checkbox">-->
            <!--<label>-->
            <!--<input type="checkbox"> 记住密码-->
            <!--</label>-->
            <!--</div>-->
        </div>
        <div class="form-group">
            <button class="button button-rounded button-royal" id="loginBtn">登录</button>
            <span id="sp"></span>
        </div>
        <div class="horizontal-line"></div>
    </div>

</div>
<div class="login-bottom">
</div>
</body>

<script>
    var initData={
        validateLoginUrl:$.getRootPath()+"api/Login/verificationLogin.json",
        gotoIndexUrl:$.getRootPath()+"api/Login/initIndex.html"
    };

    //模拟验证用户信息
    /*Mock.mock(initData.validateLoginUrl, {
     'status|200':0,
     'msg': '提交失败',
     'data':null
     });*/

    WebPro(initData);
</script>
</html>
