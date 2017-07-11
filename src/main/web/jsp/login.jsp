<%@ page contentType="text/html;charset=GBK" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <meta charset="GBK">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>登录</title>
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

                if ($("#account").val() == "") {
                    Messenger().alertErr("请输入用户名！");
                    return ;
                }
                if ($("#password").val() == "") {
                    Messenger().alertErr("请输入用户密码！");
                    return ;
                }
                console.info(initData.gotoIndexUrl);
                var url =initData.validateLoginUrl;

                var param = {
                    username : $("#account").val(),
                    password : $("#password").val()
                };

                $.ajax({
                    url:url,
                    type:'POST',
                    data:param,
                    dataType:'json',
                    success:function (data) {
                        if (data.success == false){
                            Messenger().alertErr(data.msg);
                        }else {
                            window.location.href=initData.gotoIndexUrl;
                        }
                    }
                })
            });
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
<img src="<%=basePath%>img/hrg1.png" style="width: 200px;height: 100px;margin-top: -210px">

<div class="login-form animated rotateIn">
    <div class="form-inner" id="loginInfo">
        <div class="form-group relative">
            <div class="input-group">
                <span class="input-group-addon input_icon"><i class="fa fa-envelope"></i></span>
                <input class="form-control input-lg typeahead-email" placeholder="账号" type="text" name="username" id="account"/>
            </div>
            <span class="inputTips email_inputTips"></span>
        </div>
        <div class="form-group relative">
            <div class="input-group">
                <span class="input-group-addon"><i class="fa fa-key"></i></span>
                <input class="form-control input-lg" placeholder="密码" type="password" name="password" id="password" />
            </div>
            <span class="inputTips pwd_inputTips"></span>
        </div>
        <div class="form-group">
            <button class="button button-rounded button-royal" id="loginBtn">登录</button>
            <span id="sp"></span>
        </div>
        <div class="horizontal-line"></div>
    </div>
</div>
<div class="login-bottom"></div>
</body>

<script>
    var initData={
        validateLoginUrl:$.getRootPath()+"login",
        gotoIndexUrl:$.getRootPath()+"success"}

    WebPro(initData);
</script>
</html>
