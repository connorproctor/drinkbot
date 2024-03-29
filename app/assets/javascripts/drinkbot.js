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
    	$.post("make_drink", {drink: drinkId, size: drinkSize}).done(make_success).fail(make_failure);
    });
});

function make_success(data, textStatus, jqXHR) {
	window.setTimeout(
			function() { $('#make-button').removeAttr('disabled'); }, data*1000
		);
}

function make_failure(jqXHR, textStatus, errorThrown) {
	$('#make-button').removeAttr('disabled');
	alert('Something went wrong');
}

$(document).ready(function() {
    $('.btn').button();
    $('.alert').alert();
});

// Settings stuff, TODO: Move somewhere else
$(document).ready(function() {
    $('.js-pump-primer').on('mousedown touchstart', primer_start)
});

function primer_start(e) {
    e.stopPropagation();
    var pumpId = $(this).data('pump-id');
    if (pumpId == 'all') {
        $.post("turn_on_all_pumps");
        $(document).bind('mouseup.pumpPrimer', function() {
        $.post("turn_off_all_pumps");
        $(document).unbind('mouseup.pumpPrimer');
    });
    } else {
        $.post("turn_on_pump", {pump_id: pumpId});
        $(document).bind('mouseup.pumpPrimer', function() {
        $.post("turn_off_pump", {pump_id: pumpId});
        $(document).unbind('mouseup.pumpPrimer');
    });
    }
}