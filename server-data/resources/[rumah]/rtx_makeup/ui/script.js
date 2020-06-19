$(document).ready(function(){
  // Listen for NUI Events
  window.addEventListener('message', function(event){
    // Open Skin Creator
    if(event.data.openPropertymakeupCreator == true){
      $(".PropertymakeupCreator").css("display","block");
	  $(".rotation").css("display","flex");
    }
    // Close Skin Creator
    if(event.data.openPropertymakeupCreator == false){
      $(".PropertymakeupCreator").fadeOut(400);
	  $(".rotation").css("display","none");
    }
	// Click
    if (event.data.type == "updateMaxVal") {
	  $('input.' + event.data.classname).prop('max',event.data.maxVal);
	  $('input.' + event.data.classname).val(event.data.defaultVal);
	  $('div[name=' + event.data.classname + ']').attr('data-legend', '/'+event.data.maxVal);
	  $('div[name=' + event.data.classname + ']').text(event.data.defaultVal + '/' + event.data.maxVal);
    }
  });

  // Form update
  $('input').change(function(){
    $.post('http://rtx_makeup/updateSkinSavePropertymakeup', JSON.stringify({
      value: false,
// Face
      // Propertymakeups
	  lipstick: $('.lipstick').val(),
      lipstickcolor: $('input[name=lipstickcolor]:checked', '#formPropertymakeupCreator').val(),
	  lipstickopacity: $('.lipstickthick').val(),
	  blush: $('.blush').val(),
      blushcolor: $('input[name=blushcolor]:checked', '#formPropertymakeupCreator').val(),
	  blushopacity: $('.blushthick').val(),
	  makeup: $('.makeup').val(),
      makeupcolor: $('input[name=makeupcolor]:checked', '#formPropertymakeupCreator').val(),
	  makeupcolor2: $('input[name=makeupcolor2]:checked', '#formPropertymakeupCreator').val(),
	  makeupopacity: $('.makeupthick').val(),
    }));
  });
  $('.arrow').on('click', function(e){
    e.preventDefault();
    $.post('http://rtx_makeup/updateSkinSavePropertymakeup', JSON.stringify({
      value: false,
      // Face
      // Propertymakeups
	  lipstick: $('.lipstick').val(),
      lipstickcolor: $('input[name=lipstickcolor]:checked', '#formPropertymakeupCreator').val(),
	  lipstickopacity: $('.lipstickthick').val(),
	  blush: $('.blush').val(),
      blushcolor: $('input[name=blushcolor]:checked', '#formPropertymakeupCreator').val(),
	  blushopacity: $('.blushthick').val(),
	  makeup: $('.makeup').val(),
      makeupcolor: $('input[name=makeupcolor]:checked', '#formPropertymakeupCreator').val(),
	  makeupcolor2: $('input[name=makeupcolor2]:checked', '#formPropertymakeupCreator').val(),
	  makeupopacity: $('.makeupthick').val(),
    }));
  });

  // Form submited
  $('.yes').on('click', function(e){
    e.preventDefault();
    $.post('http://rtx_makeup/updateSkinSavePropertymakeup', JSON.stringify({
      value: true,
      // Propertymakeups
	  lipstick: $('.lipstick').val(),
      lipstickcolor: $('input[name=lipstickcolor]:checked', '#formPropertymakeupCreator').val(),
	  lipstickopacity: $('.lipstickthick').val(),
	  blush: $('.blush').val(),
      blushcolor: $('input[name=blushcolor]:checked', '#formPropertymakeupCreator').val(),
	  blushopacity: $('.blushthick').val(),
	  makeup: $('.makeup').val(),
      makeupcolor: $('input[name=makeupcolor]:checked', '#formPropertymakeupCreator').val(),
	  makeupcolor2: $('input[name=makeupcolor2]:checked', '#formPropertymakeupCreator').val(),
	  makeupopacity: $('.makeupthick').val(),
    }));
  }); 
  // Rotate player
  $(document).keypress(function(e) {
    if(e.which == 97){ // A pressed
      $.post('http://rtx_makeup/rotaterightheading', JSON.stringify({
        value: 10
      }));
    }
    if(e.which == 101){ // E pressed
      $.post('http://rtx_makeup/rotateleftheading', JSON.stringify({
        value: 10
      }));
    }
  });

  // Zoom out camera for Propertymakeups
  $('#tabs label').on('click', function(e){
    //e.preventDefault();
    $.post('http://rtx_makeup/zoom', JSON.stringify({
      zoom: $(this).attr('data-link')
    }));
  });
});
