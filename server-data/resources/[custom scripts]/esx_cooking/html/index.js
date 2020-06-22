$(function () {

    //Order Menu
    OpenMenu(false)
    OpenMenu1(false)

    //Kitchen Menu
    OpenMenu2(false)

    //Order Menu
    function OpenMenu(bool) {
        if (bool == true) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type == "enableui") {
            if (item.enable == true) {
                OpenMenu(true)
            } else {
                OpenMenu(false)
            }
        }
    })

    function OpenMenu1(bool) {
        if (bool == true) {
            $("#container1").show();
        } else {
            $("#container1").hide();
        }
    }

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type1 == "enableui1") {
            if (item.enable1 == true) {
                OpenMenu1(true)
            } else {
                OpenMenu1(false)
            }
        }
    })

    //Kitchen Menu
    function OpenMenu2(bool) {
        if (bool == true) {
            $("#containerk").show();
        } else {
            $("#containerk").hide();
        }
    }

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type2 == "enableui2") {
            if (item.enable2 == true) {
                OpenMenu2(true)
            } else {
                OpenMenu2(false)
            }
        }
    })

    //Order Menu Buttons
    //Burger Buttons
    $('#bbb').click(function() {
        $.post('http://esx_cooking/buybreadb', JSON.stringify({
            
        }))
    })

    $('#bce').click(function() {
        $.post('http://esx_cooking/buycheese', JSON.stringify({
            
        }))
    })
    
    $('#bmt').click(function() {
        $.post('http://esx_cooking/buymeat', JSON.stringify({
            
        }))
    })

    //Sandwich Buttons
    $('#bbs').click(function() {
        $.post('http://esx_cooking/buybreads', JSON.stringify({
            
        }))
    })

    $('#bce1').click(function() {
        $.post('http://esx_cooking/buycheese1', JSON.stringify({
            
        }))
    })

    $('#bhm').click(function() {
        $.post('http://esx_cooking/buyham', JSON.stringify({
            
        }))
    })

    //Hot Dog Buttons
    $('#bbh').click(function() {
        $.post('http://esx_cooking/buybreadh', JSON.stringify({
            
        }))
    })

    $('#bse').click(function() {
        $.post('http://esx_cooking/buysausage', JSON.stringify({
            
        }))
    })
    
    //Kitchen Menu Buttons
    $('#bc1').click(function() {
        $.post('http://esx_cooking/makeburger', JSON.stringify({
            
        }))
    })

    $('#bc2').click(function() {
        $.post('http://esx_cooking/makesandwich', JSON.stringify({
            
        }))
    })

    $('#bc3').click(function() {
        $.post('http://esx_cooking/makehotdog', JSON.stringify({
            
        }))
    })

    //General
    $(document).keyup(function(event) {
        if (event.keyCode == 27){
            $.post('http://esx_cooking/close', JSON.stringify({
                
            }))
        }
    })

    $('.page-prv').click(function(){
        $("#container1").hide();
        $("#container").show();
        $.post('http://esx_cooking/page-prv', JSON.stringify({
                
        }))
    })

    $('.page-nxt').click(function(){
        $("#container").hide();
        $("#container1").show();
        $.post('http://esx_cooking/page-nxt', JSON.stringify({
                
        }))
    })
})