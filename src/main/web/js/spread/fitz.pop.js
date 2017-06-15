$(function(){
	
	
	$(".pickup-order-tbd tr").click(function(){
	
	var code = $(this).attr("date-code");
	var take = $(this).attr("date-take");
	if(code){	
		$(".popbg-codes").text(code);
		$(".popbg-takes").text(take);
		$("#pick-order-pop").show();
		var pic=document.getElementById('imgss');
		pic.src='/washbox/wechat/order/getImage.do?barcode='+code;
		$(".bg-black").show();
	}
	})
	
	
	$(".bg-black").click(function(){
	$("#pick-order-pop").hide();
	$(".bg-black").hide();
	})
})
