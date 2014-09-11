$(document).ready(function() {
    $('.drink-image').click(function() {
    	$('.selected-drink').removeClass("selected-drink");
        $(this).addClass("selected-drink");
    });
});

$(document).ready(function() {
    $('#make-button').click(function() {
    	$('#make-button').attr('disabled', 'disabled');
    	var drinkId = $('.selected-drink').data('drink-id');
    	var drinkSize = $('input[name=drink-size]:checked').val();
    	if (!drinkId) {
    		alert('Please select a drink first.');
    		$('#make-button').removeAttr('disabled');
    		return;
    	}
    	if (!drinkSize) {
    		alert('Please select a size first.');
    		$('#make-button').removeAttr('disabled');
    		return;
    	}
    	$.post("make_drink", {drink: drinkId, size: drinkSize}).done(success).fail(failure);
    });
});

function success(data, textStatus, jqXHR) {
	window.setTimeout(
			function() { $('#make-button').removeAttr('disabled'); }, data*1000
		);
}

function failure(jqXHR, textStatus, errorThrown) {
	$('#make-button').removeAttr('disabled');
	alert('Something went wrong');
}

$('.btn').button();
$(".alert").alert()