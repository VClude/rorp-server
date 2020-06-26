var prices = {}
var maxes = {}
var zone = null
var ingredients = {};

// Partial Functions
function closeMain() {
	$("body").css("display", "none");
}
function openMain() {
	$("body").css("display", "block");
}
function closeAll() {
	$(".body").css("display", "none");
}
function cooking() {
	$.post('http://rorp_pedagang/cookingNUI', JSON.stringify(ingredients));
	$.post('http://rorp_pedagang/NUIFocusOff');
}
$(document).ready(function () {
			
});
$(".close").click(function(){
    $.post('http://rorp_pedagang/quit', JSON.stringify({}));
});
$(function(){
	window.onload = function(e){
		window.addEventListener('message', function(event){
			var item = event.data;
			console.log("Received data")
			if (item.display === true) {
				$( ".iqdropdown-menu" ).empty();
				$(".ingredients").unbind();
				ingredients = {};
				for (var i = 0; i < item.inventory.length; i++) {
					var obj = item.inventory[i]
					$( ".iqdropdown-menu" ).append('<li data-id="' + obj.name + '" data-maxcount=' + obj.count + '><div> ' + obj.label + '<span>Tambahkan ' + obj.label + ' ke daftar bahan memasak.</span> </div></li>');
					//Do something
				}
				$(".ingredients").iqDropdown({
					selectionText: 'ingredient',
					textPlural: 'ingredients',
					onChange: function (id, count, totalItems) {
						ingredients[id] = count
					},
				});
				$('.container').show()
			} else if (item.display === false) {
				$('.container').hide();
			}
		});
		
		document.onkeyup = function (data) {
			if (data.which == 27) { // Escape key
				$.post('http://rorp_pedagang/NUIFocusOff');
			}
		};
	};
});
// Listen for NUI Events
window.addEventListener('message', function (event) {

	var item = event.data;

	// Open & Close main window
	if (item.message == "show") {
		if (item.clear == true){
			$( ".home" ).empty();
			prices = {}
			maxes = {}
			zone = null
		}
		openMain();
	}

	if (item.message == "hide") {
		closeMain();
	}

	if (item.message == "add"){
		$( ".home" ).append('<div class="card">' +
					'<div class="image-holder">' +
						'<img src="img/' + item.item + '.png" onerror="this.src = \'img/default.png\'" alt="' + item.label + '" style="width:100%">' +
					'</div>' +
					'<div class="container">' +
						'<h4><b>' + item.label + '<div class="price">' + item.price + '$' + '</div>' + '</b></h4> ' +
						'<div class="quantity">' +
							'<div class="minus-btn btnquantity" name="' + item.item + '" id="minus">' +
								'<img src="img/minus.png" alt="" />' +
							'</div>' +
							'<div class="number" name="name">1</div>' +
							'<div class="plus-btn btnquantity" name="' + item.item + '" id="plus">' +
								'<img src="img/plus.png" alt="" />' +
							'</div>' +
						'</div>' +
						'<div class="purchase">' +

							'<div class="buy" name="' + item.item + '">Buy</div>' +
						'</div>' +
					'</div>' +
				'</div>');
		prices[item.item] = item.price;
		maxes[item.item] = 99;
		zone = item.loc;
	}
});

$(".home").on("click", ".btnquantity", function() {

	var $button = $(this);
	var $name = $button.attr('name')
	var oldValue = $button.parent().find(".number").text();
	if ($button.get(0).id == "plus") {
		if (oldValue <  maxes[$name]){
			var newVal = parseFloat(oldValue) + 1;
		}else{
			var newVal = parseFloat(oldValue);
		}
	} else {
	// Don't allow decrementing below zero
		if (oldValue > 1) {
			var newVal = parseFloat(oldValue) - 1;
		} else {
			newVal = 1;
		}
	}
	$button.parent().parent().find(".price").text((prices[$name] * newVal) + "$");
	$button.parent().find(".number").text(newVal);

});

$(".home").on("click", ".buy", function() {
	var $button = $(this);
	var $name = $button.attr('name')
	var $count = parseFloat($button.parent().parent().find(".number").text());
	$.post('http://rorp_pedagang/purchase', JSON.stringify({
		item: $name,
		count: $count,
		loc: zone
	}));
});
