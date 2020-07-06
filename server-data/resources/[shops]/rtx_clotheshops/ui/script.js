$(document).ready(function(){
  // Listen for NUI Events
  window.addEventListener('message', function(event){
    // Open Skin Creator
    if(event.data.openClotheCreator == true){
      $(".ClotheCreator").css("display","block");
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
    if(event.data.openClotheCreator == false){
      $(".ClotheCreator").fadeOut(400);
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
    $.post('http://rtx_clotheshops/updateSkinSave', JSON.stringify({
      value: false,
// Face
      // Clothes
      hats: $('.chapeaux .active').attr('data'),
	  hats_texture: $('input[class=helmet_2]').val(),
	  masks: $('.maskes .active').attr('data'),
	  masks_texture: $('input[class=mask_2]').val(),
      glasses: $('.lunettes .active').attr('data'),
	  glasses_texture: $('input[class=glasses_2]').val(),
      ears: $('.oreilles .active').attr('data'),
	  ears_texture: $('input[class=ears_2]').val(),
      tops: $('.hauts .active').attr('data'),
	  tops_texture: $('input[class=torso_2]').val(),
	  tops_texture2: $('input[class=tshirt_2]').val(),
      pants: $('.pantalons .active').attr('data'),
	  pants_texture: $('input[class=pants_2]').val(),
      shoes: $('.chaussures .active').attr('data'),
	  shoes_texture: $('input[class=shoes_2]').val(),
      watches: $('.montre .active').attr('data'),
	  watches_texture: $('input[class=watches_2]').val(),
      bracelets: $('.braceletes .active').attr('data'),
	  bracelets_texture: $('input[class=bracelets_2]').val(),
      bag: $('.bages .active').attr('data'),
	  bag_texture: $('input[class=bags_2]').val(),
      chain: $('.chaines .active').attr('data'),
	  chain_texture: $('input[class=chain_2]').val(),
    }));
  });
  $('.arrow').on('click', function(e){
    e.preventDefault();
    $.post('http://rtx_clotheshops/updateSkinSave', JSON.stringify({
      value: false,
      // Face
      // Clothes
      hats: $('.chapeaux .active').attr('data'),
	  hats_texture: $('input[class=helmet_2]').val(),
	  masks: $('.maskes .active').attr('data'),
	  masks_texture: $('input[class=mask_2]').val(),
      glasses: $('.lunettes .active').attr('data'),
	  glasses_texture: $('input[class=glasses_2]').val(),
      ears: $('.oreilles .active').attr('data'),
	  ears_texture: $('input[class=ears_2]').val(),
      tops: $('.hauts .active').attr('data'),
	  tops_texture: $('input[class=torso_2]').val(),
	  tops_texture2: $('input[class=tshirt_2]').val(),
      pants: $('.pantalons .active').attr('data'),
	  pants_texture: $('input[class=pants_2]').val(),
      shoes: $('.chaussures .active').attr('data'),
	  shoes_texture: $('input[class=shoes_2]').val(),
      watches: $('.montre .active').attr('data'),
	  watches_texture: $('input[class=watches_2]').val(),
      bracelets: $('.braceletes .active').attr('data'),
	  bracelets_texture: $('input[class=bracelets_2]').val(),
      bag: $('.bages .active').attr('data'),
	  bag_texture: $('input[class=bags_2]').val(),
      chain: $('.chaines .active').attr('data'),
	  chain_texture: $('input[class=chain_2]').val(),
    }));
  });

  // Form submited
  $('.yes').on('click', function(e){
    e.preventDefault();
    $.post('http://rtx_clotheshops/updateSkinSave', JSON.stringify({
      value: true,
      // Clothes
      hats: $('.chapeaux .active').attr('data'),
	  hats_texture: $('input[class=helmet_2]').val(),
	  masks: $('.maskes .active').attr('data'),
	  masks_texture: $('input[class=mask_2]').val(),
      glasses: $('.lunettes .active').attr('data'),
	  glasses_texture: $('input[class=glasses_2]').val(),
      ears: $('.oreilles .active').attr('data'),
	  ears_texture: $('input[class=ears_2]').val(),
      tops: $('.hauts .active').attr('data'),
	  tops_texture: $('input[class=torso_2]').val(),
	  tops_texture2: $('input[class=tshirt_2]').val(),
      pants: $('.pantalons .active').attr('data'),
	  pants_texture: $('input[class=pants_2]').val(),
      shoes: $('.chaussures .active').attr('data'),
	  shoes_texture: $('input[class=shoes_2]').val(),
      watches: $('.montre .active').attr('data'),
	  watches_texture: $('input[class=watches_2]').val(),
      bracelets: $('.braceletes .active').attr('data'),
	  bracelets_texture: $('input[class=bracelets_2]').val(),
      bag: $('.bages .active').attr('data'),
	  bag_texture: $('input[class=bags_2]').val(),
      chain: $('.chaines .active').attr('data'),
	  chain_texture: $('input[class=chain_2]').val(),
    }));
  }); 
  // Rotate player
  $(document).keypress(function(e) {
    if(e.which == 97){ // A pressed
      $.post('http://rtx_clotheshops/rotaterightheading', JSON.stringify({
        value: 10
      }));
    }
    if(e.which == 101){ // E pressed
      $.post('http://rtx_clotheshops/rotateleftheading', JSON.stringify({
        value: 10
      }));
    }
  });

  // Zoom out camera for clothes
  $('#tabs label').on('click', function(e){
    //e.preventDefault();
    $.post('http://rtx_clotheshops/zoom', JSON.stringify({
      zoom: $(this).attr('data-link')
    }));
  });
});
