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

$('.btn').button();
$(".alert").alert()

// Settings stuff, TODO: Move
$(document).ready(function() {
    $('.js-pump-primer').mousedown(function() {
        var pumpId = $(this).data('pump-id');
        $.post("turn_on_pump", {pump_id: pumpId});
        $(document).bind('mouseup.pumpPrimer', function() {
            $.post("turn_off_pump", {pump_id: pumpId});
            $(document).unbind('click.pumpPrimer')
        });
    });
});


//combobox on settings page, TODO: Move
(function( $ ) {
    $.widget( "custom.combobox", {
      _create: function() {
        this.wrapper = $( "<span>" )
          .addClass( "custom-combobox" )
          .insertAfter( this.element );
 
        this.element.hide();
        this._createAutocomplete();
        this._createShowAllButton();
      },
 
      _createAutocomplete: function() {
        var selected = this.element.children( ":selected" ),
          value = selected.val() ? selected.text() : "";
 
        this.input = $( "<input>" )
          .appendTo( this.wrapper )
          .val( value )
          .attr( "title", "" )
          .addClass( "custom-combobox-input ui-widget ui-widget-content ui-state-default ui-corner-left" )
          .autocomplete({
            delay: 0,
            minLength: 0,
            source: $.proxy( this, "_source" )
          })
          .tooltip({
            tooltipClass: "ui-state-highlight"
          });
 
        this._on( this.input, {
          autocompleteselect: function( event, ui ) {
            ui.item.option.selected = true;
            this._trigger( "select", event, {
              item: ui.item.option
            });
          },
 
          autocompletechange: "_removeIfInvalid"
        });
      },
 
      _createShowAllButton: function() {
        var input = this.input,
          wasOpen = false;
 
        $( "<a>" )
          .attr( "tabIndex", -1 )
          .attr( "title", "Show All Items" )
          .tooltip()
          .appendTo( this.wrapper )
          .button({
            icons: {
              primary: "ui-icon-triangle-1-s"
            },
            text: false
          })
          .removeClass( "ui-corner-all" )
          .addClass( "custom-combobox-toggle ui-corner-right" )
          .mousedown(function() {
            wasOpen = input.autocomplete( "widget" ).is( ":visible" );
          })
          .click(function() {
            input.focus();
 
            // Close if already visible
            if ( wasOpen ) {
              return;
            }
 
            // Pass empty string as value to search for, displaying all results
            input.autocomplete( "search", "" );
          });
      },
 
      _source: function( request, response ) {
        var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
        response( this.element.children( "option" ).map(function() {
          var text = $( this ).text();
          if ( this.value && ( !request.term || matcher.test(text) ) )
            return {
              label: text,
              value: text,
              option: this
            };
        }) );
      },
 
      _removeIfInvalid: function( event, ui ) {
 
        // Selected an item, nothing to do
        if ( ui.item ) {
          return;
        }
 
        // Search for a match (case-insensitive)
        var value = this.input.val(),
          valueLowerCase = value.toLowerCase(),
          valid = false;
        this.element.children( "option" ).each(function() {
          if ( $( this ).text().toLowerCase() === valueLowerCase ) {
            this.selected = valid = true;
            return false;
          }
        });
 
        // Found a match, nothing to do
        if ( valid ) {
          return;
        }
 
        // Remove invalid value
        this.input
          .val( "" )
          .attr( "title", value + " didn't match any item" )
          .tooltip( "open" );
        this.element.val( "" );
        this._delay(function() {
          this.input.tooltip( "close" ).attr( "title", "" );
        }, 2500 );
        this.input.autocomplete( "instance" ).term = "";
      },
 
      _destroy: function() {
        this.wrapper.remove();
        this.element.show();
      }
    });
  })( jQuery );
 
  $(function() {
    $( "#combobox" ).combobox();
    $( "#toggle" ).click(function() {
      $( "#combobox" ).toggle();
    });
  });

