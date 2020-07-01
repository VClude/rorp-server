$(document).ready(function(){
  // Listen for NUI Events
  window.addEventListener('message', function(event){
    // Open Skin Creator
    if(event.data.openBarberCreator == true){
      $(".BarberCreator").css("display","block");
	  $(".rotation").css("display","flex");
	  
	  if (event.data.gender == "male") {
		$('#female').remove();
		$('#male').show();
	  }
	  if (event.data.gender == "female") {
		$('#male').remove();
		$('#female').show();
	  }
    }
    // Close Skin Creator
    if(event.data.openBarberCreator == false){
      $(".BarberCreator").fadeOut(400);
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
    $.post('http://rorp_barbershop/updateSkinSaveBarber', JSON.stringify({
      value: false,
// Face
      // Barbers
      hair: $('.hair').val(),
      haircolor: $('input[name=haircolor]:checked', '#formBarberCreator').val(),
	  haircolor2: $('input[name=haircolor2]:checked', '#formBarberCreator').val(),
	  lipstick: $('.lipstick').val(),
      lipstickcolor: $('input[name=lipstickcolor]:checked', '#formBarberCreator').val(),
	  lipstickopacity: $('.lipstickthick').val(),
	  blush: $('.blush').val(),
      blushcolor: $('input[name=blushcolor]:checked', '#formBarberCreator').val(),
	  blushopacity: $('.blushthick').val(),
	  makeup: $('.makeup').val(),
      makeupcolor: $('input[name=makeupcolor]:checked', '#formBarberCreator').val(),
	  makeupcolor2: $('input[name=makeupcolor2]:checked', '#formBarberCreator').val(),
	  makeupopacity: $('.makeupthick').val(),
      eyebrow: $('.sourcils').val(),
      eyebrowopacity: $('.epaisseursourcils').val(),
      beard: $('.barbe').val(),
      beardopacity: $('.epaisseurbarbe').val(),
      beardcolor: $('input[name=barbecolor]:checked', '#formBarberCreator').val(),
    }));
  });
  $('.arrow').on('click', function(e){
    e.preventDefault();
    $.post('http://rorp_barbershop/updateSkinSaveBarber', JSON.stringify({
      value: false,
      // Face
      // Barbers
      hair: $('.hair').val(),
      haircolor: $('input[name=haircolor]:checked', '#formBarberCreator').val(),
	  haircolor2: $('input[name=haircolor2]:checked', '#formBarberCreator').val(),
	  lipstick: $('.lipstick').val(),
      lipstickcolor: $('input[name=lipstickcolor]:checked', '#formBarberCreator').val(),
	  lipstickopacity: $('.lipstickthick').val(),
	  blush: $('.blush').val(),
      blushcolor: $('input[name=blushcolor]:checked', '#formBarberCreator').val(),
	  blushopacity: $('.blushthick').val(),
	  makeup: $('.makeup').val(),
      makeupcolor: $('input[name=makeupcolor]:checked', '#formBarberCreator').val(),
	  makeupcolor2: $('input[name=makeupcolor2]:checked', '#formBarberCreator').val(),
	  makeupopacity: $('.makeupthick').val(),
      eyebrow: $('.sourcils').val(),
      eyebrowopacity: $('.epaisseursourcils').val(),
      beard: $('.barbe').val(),
      beardopacity: $('.epaisseurbarbe').val(),
      beardcolor: $('input[name=barbecolor]:checked', '#formBarberCreator').val(),
    }));
  });

  // Form submited
  $('.yes').on('click', function(e){
    e.preventDefault();
    $.post('http://rorp_barbershop/updateSkinSaveBarber', JSON.stringify({
      value: true,
      // Barbers
      hair: $('.hair').val(),
      haircolor: $('input[name=haircolor]:checked', '#formBarberCreator').val(),
	  haircolor2: $('input[name=haircolor2]:checked', '#formBarberCreator').val(),
	  lipstick: $('.lipstick').val(),
      lipstickcolor: $('input[name=lipstickcolor]:checked', '#formBarberCreator').val(),
	  lipstickopacity: $('.lipstickthick').val(),
	  blush: $('.blush').val(),
      blushcolor: $('input[name=blushcolor]:checked', '#formBarberCreator').val(),
	  blushopacity: $('.blushthick').val(),
	  makeup: $('.makeup').val(),
      makeupcolor: $('input[name=makeupcolor]:checked', '#formBarberCreator').val(),
	  makeupcolor2: $('input[name=makeupcolor2]:checked', '#formBarberCreator').val(),
	  makeupopacity: $('.makeupthick').val(),
      eyebrow: $('.sourcils').val(),
      eyebrowopacity: $('.epaisseursourcils').val(),
      beard: $('.barbe').val(),
      beardopacity: $('.epaisseurbarbe').val(),
      beardcolor: $('input[name=barbecolor]:checked', '#formBarberCreator').val(),
    }));
  }); 
  // Rotate player
  $(document).keypress(function(e) {
    if(e.which == 97){ // A pressed
      $.post('http://rorp_barbershop/rotaterightheading', JSON.stringify({
        value: 10
      }));
    }
    if(e.which == 101){ // E pressed
      $.post('http://rorp_barbershop/rotateleftheading', JSON.stringify({
        value: 10
      }));
    }
  });

  // Zoom out camera for Barbers
  $('#tabs label').on('click', function(e){
    //e.preventDefault();
    $.post('http://rorp_barbershop/zoom', JSON.stringify({
      zoom: $(this).attr('data-link')
    }));
  });
});
