$(document).ready(function(){

//		账户设置-修改密码弹窗
		$("#userset-close-pop").click(function(){

			$("#set-old-pwd").val("");
			$("#set-new-pwd").val("");
			$("#set-re-pwd").val("");
			$("#pop-bg").hide();

		});

		$("#loginpwd-setting").click(function(){
			$("#pop-bg").show();
			$(".user-set-butp>button").attr("data-type","update_login_pwd");
		});

		$("#paypwd-setting").click(function(){
			$("#pop-bg").show();
			$(".user-set-butp>button").attr("data-type","update_pay_pwd");
		});
		
//		修改密码ajax提交
		$("#user-set-subbs").click(function(){
			var type 				= $(this).attr("data-type");
			var oldp 				= $("#set-old-pwd").val();
			var newp				= $("#set-new-pwd").val();
			var rep					= $("#set-re-pwd").val();
			if (oldp&&newp&&rep) {
				
				if(newp!=rep){
					alert('两次密码不一样!');
					return false;
				}

			$.ajax({
                    url:'?act='+type,
                    type:'post',
                    data:{oldpwd:oldp,newpwd:newp,repwd:rep},
                    dataType:'json',
                    success:function(data){   	
//                  	var data 			= arguments[0];
						if(data.status==1){
							$("#pop-bg").hide();
						}
						alert(data.error_desc);
                    },
                    error:function(data){

                    }
                });
			}else{
				alert("输入有误！");
			}

		});
		
//		头部右侧按钮事件
		$(".header-right").click(function(){
        $(".header-more-pops").show();
            return false;//关键是这里，阻止冒泡
        });
        $(".header-more-pops").click(function(){
            return false;
        });
        $(document).click(function(){
            $(".header-more-pops").hide();
        });
//guanbi how used tiao code
        $("#how-use-codes").click(function(){
        	$("#tips-pop-bg").show();
        })
        $("#tips-pop-bg .close").click(function(){
        	$("#tips-pop-bg").hide();
        })
        
        
        
//		帮助页面打开关闭详细信息	
		$(".help-more").click(function(){

			var open					= $(this).next(".question-content-li");
			
			$(open).toggle();
			
			if($(this).find(".right-hp").hasClass("right-ups")){
				
				$(this).find(".right-hp").toggleClass("right-ups");
			}else{
				$(this).find(".right-hp").toggleClass("right-ups");
			}
					
		})
		
});