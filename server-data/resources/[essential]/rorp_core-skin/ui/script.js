$(document).ready(function(){
  // Listen for NUI Events
  window.addEventListener('message', function(event){
    // Open Skin Creator
    if(event.data.openSkinCreator == true){
      $(".skinCreator").css("display","block");
	  $(".rotation").css("display","flex");
	  
	  if (event.data.gender == "muz") {
		$('#female').remove();
		$('#male').show();
		$('#female2').remove();
		$('#male2').show();
	  }
	  if (event.data.gender == "zena") {
		$('#male').remove();
		$('#female').show();
		$('#male2').remove();
		$('#female2').show();
	  }
    }
    // Close Skin Creator
    if(event.data.openSkinCreator == false){
      $(".skinCreator").fadeOut(400);
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
    $.post('http://rorp_core-skin/updateSkin', JSON.stringify({
      value: false,
      // Face
      dad: $('input[name=pere]:checked', '#formSkinCreator').val(),
      mum: $('input[name=mere]:checked', '#formSkinCreator').val(),
      dadmumpercent: $('.morphologie').val(),
      skin: $('input[name=peaucolor]:checked', '#formSkinCreator').val(),
      eyecolor: $('input[name=eyecolor]:checked','#formSkinCreator').val(),
      acne: $('.acne').val(),
      skinproblem: $('.pbpeau').val(),
      freckle: $('.tachesrousseur').val(),
      wrinkle: $('.rides').val(),
      wrinkleopacity: $('.rides').val(),
      hair: $('.hair').val(),
      haircolor: $('input[name=haircolor]:checked', '#formSkinCreator').val(),
	  haircolor2: $('input[name=haircolor2]:checked', '#formSkinCreator').val(),
	  lipstick: $('.lipstick').val(),
      lipstickcolor: $('input[name=lipstickcolor]:checked', '#formSkinCreator').val(),
	  lipstickopacity: $('.lipstickthick').val(),
	  blush: $('.blush').val(),
      blushcolor: $('input[name=blushcolor]:checked', '#formSkinCreator').val(),
	  blushopacity: $('.blushthick').val(),
	  makeup: $('.makeup').val(),
      makeupcolor: $('input[name=makeupcolor]:checked', '#formSkinCreator').val(),
	  makeupcolor2: $('input[name=makeupcolor2]:checked', '#formSkinCreator').val(),
	  makeupopacity: $('.makeupthick').val(),
      eyebrow: $('.sourcils').val(),
      eyebrowopacity: $('.epaisseursourcils').val(),
      beard: $('.barbe').val(),
      beardopacity: $('.epaisseurbarbe').val(),
      beardcolor: $('input[name=barbecolor]:checked', '#formSkinCreator').val(),
    }));
  });
  $('.arrow').on('click', function(e){
    e.preventDefault();
    $.post('http://rorp_core-skin/updateSkin', JSON.stringify({
      value: false,
      // Face
      dad: $('input[name=pere]:checked', '#formSkinCreator').val(),
      mum: $('input[name=mere]:checked', '#formSkinCreator').val(),
      dadmumpercent: $('.morphologie').val(),
      skin: $('input[name=peaucolor]:checked', '#formSkinCreator').val(),
      eyecolor: $('input[name=eyecolor]:checked','#formSkinCreator').val(),
      acne: $('.acne').val(),
      skinproblem: $('.pbpeau').val(),
      freckle: $('.tachesrousseur').val(),
      wrinkle: $('.rides').val(),
      wrinkleopacity: $('.rides').val(),
      hair: $('.hair').val(),
      haircolor: $('input[name=haircolor]:checked', '#formSkinCreator').val(),
	  haircolor2: $('input[name=haircolor2]:checked', '#formSkinCreator').val(),
	  lipstick: $('.lipstick').val(),
      lipstickcolor: $('input[name=lipstickcolor]:checked', '#formSkinCreator').val(),
	  lipstickopacity: $('.lipstickthick').val(),
	  blush: $('.blush').val(),
      blushcolor: $('input[name=blushcolor]:checked', '#formSkinCreator').val(),
	  blushopacity: $('.blushthick').val(),
	  makeup: $('.makeup').val(),
      makeupcolor: $('input[name=makeupcolor]:checked', '#formSkinCreator').val(),
	  makeupcolor2: $('input[name=makeupcolor2]:checked', '#formSkinCreator').val(),
	  makeupopacity: $('.makeupthick').val(),
      eyebrow: $('.sourcils').val(),
      eyebrowopacity: $('.epaisseursourcils').val(),
      beard: $('.barbe').val(),
      beardopacity: $('.epaisseurbarbe').val(),
      beardcolor: $('input[name=barbecolor]:checked', '#formSkinCreator').val(),
    }));
  });

  // Form submited
  $('.yes').on('click', function(e){
    e.preventDefault();
    $.post('http://rorp_core-skin/updateSkin', JSON.stringify({
      value: true,
      // Face
      dad: $('input[name=pere]:checked', '#formSkinCreator').val(),
      mum: $('input[name=mere]:checked', '#formSkinCreator').val(),
      dadmumpercent: $('.morphologie').val(),
      skin: $('input[name=peaucolor]:checked', '#formSkinCreator').val(),
      eyecolor: $('input[name=eyecolor]:checked','#formSkinCreator').val(),
      acne: $('.acne').val(),
      skinproblem: $('.pbpeau').val(),
      freckle: $('.tachesrousseur').val(),
      wrinkle: $('.rides').val(),
      wrinkleopacity: $('.rides').val(),
      hair: $('.hair').val(),
      haircolor: $('input[name=haircolor]:checked', '#formSkinCreator').val(),
	  haircolor2: $('input[name=haircolor2]:checked', '#formSkinCreator').val(),
	  lipstick: $('.lipstick').val(),
      lipstickcolor: $('input[name=lipstickcolor]:checked', '#formSkinCreator').val(),
	  lipstickopacity: $('.lipstickthick').val(),
	  blush: $('.blush').val(),
      blushcolor: $('input[name=blushcolor]:checked', '#formSkinCreator').val(),
	  blushopacity: $('.blushthick').val(),
	  makeup: $('.makeup').val(),
      makeupcolor: $('input[name=makeupcolor]:checked', '#formSkinCreator').val(),
	  makeupcolor2: $('input[name=makeupcolor2]:checked', '#formSkinCreator').val(),
	  makeupopacity: $('.makeupthick').val(),
      eyebrow: $('.sourcils').val(),
      eyebrowopacity: $('.epaisseursourcils').val(),
      beard: $('.barbe').val(),
      beardopacity: $('.epaisseurbarbe').val(),
      beardcolor: $('input[name=barbecolor]:checked', '#formSkinCreator').val(),
      // Clothes
    }));
  }); 
  // Rotate player
  $(document).keypress(function(e) {
    if(e.which == 97){ // A pressed
      $.post('http://rorp_core-skin/rotaterightheading', JSON.stringify({
        value: 10
      }));
    }
    if(e.which == 101){ // E pressed
      $.post('http://rorp_core-skin/rotateleftheading', JSON.stringify({
        value: 10
      }));
    }
  });

  // Zoom out camera for clothes
  $('#tabs label').on('click', function(e){
    //e.preventDefault();
    $.post('http://rorp_core-clothe/zoom', JSON.stringify({
      zoom: $(this).attr('data-link')
    }));
  });
});
