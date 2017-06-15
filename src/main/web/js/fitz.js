$(function(){
	$(".index-a a").click(function(){
		var stus = $(this).find(".black-bg").css("display");
		if(stus == "none"){
		$(".black-bg").hide();
		$(this).find(".black-bg").show();
		/*$(this).find(".black-bg").toggle();*/
		}else{
			$(this).find(".black-bg").hide();
		}
	})
})