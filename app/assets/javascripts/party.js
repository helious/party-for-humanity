$(function() {
	$('#invite-guests').on('click', function(e) {
		window.location = $(this).children('a').attr('href');
	});
})