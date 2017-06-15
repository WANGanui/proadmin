$(function() {
	$(window).on('resize', function () {
		var height = $('.main .top').height();
		$('.main-content').css('top', height + 10);
	});

	$('.side .table-wrapper tr').click(function(){
		$(this).toggleClass('active');
	});
});