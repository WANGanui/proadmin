var json;
$(function(){
	$.ajax({    
		url:'../WXToolsHelper/tocomment.do', 
		data:{
			url:window.location.href,
			num:1
		},                                  
		type:'POST',    
		dataType:'json',
		success:function(data){   
			    json = data.config;
			    var appId = json.appId;
				var timestamp = json.timestamp;
				var nonceStr = json.nonceStr;
				var signature = json.signature;
				var accesstoken = json.accesstoken;
wx.config({
        debug: false,
        appId: appId,
        timestamp: timestamp,
        nonceStr: nonceStr,
        signature: signature,
        jsApiList: [
            'onMenuShareTimeline'
        ]
    });
  wx.ready(function () {
	  //分享朋友圈
	  wx.onMenuShareTimeline({
		    title: '搓衣板来了', // 分享标题
		    link: 'http://box.cuoyiban.net/action/weixin/index.php?act=index', // 分享链接
		    imgUrl: 'http://image.cuoyiban.net/box/cuoyiban.jpg', // 分享图标
		    success: function () { 
		    	alert("分享成功！");
		    },
		    cancel: function () { 
		    	alert("分享取消！");
		        // 用户取消分享后执行的回调函数
		    }
		});
     });
				                }
				            });
})