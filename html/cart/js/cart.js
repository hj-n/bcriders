/* JS Document */

/******************************

[Table of Contents]

1. Vars and Inits
2. Set Header
3. Init Search
4. Init Menu
5. Init Quantity


******************************/

$(document).ready(function()
{
	"use strict";

	/* 

	1. Vars and Inits

	*/

	var header = $('.header');
	var hambActive = false;
	var menuActive = false;
	var totals = document.getElementsByClassName('cart_total_value ml-auto');
	var totals2 = document.getElementById('cart_total_value ml-auto22');
	$("#confirm_next").click(function(){
		if(confirm("After order, cancel is impossible. Continue?")){
			alert('order confirmed');
			window.location.href = "../main/index.html";
		}
		else {
			void("");
		}
	})
	setHeader();

	$(window).on('resize', function()
	{
		setHeader();
	});

	$(document).on('scroll', function()
	{
		setHeader();
	});

	initSearch();
	initMenu();
	initQuantity();
	initQuantityy();
	initQuantityyy();
	multiplytotal();
	/* 

	2. Set Header

	*/

	function setHeader()
	{
		if($(window).scrollTop() > 100)
		{
			header.addClass('scrolled');
		}
		else
		{
			header.removeClass('scrolled');
		}
	}

	/* 

	3. Init Search

	*/

	function initSearch()
	{
		if($('.search').length && $('.search_panel').length)
		{
			var search = $('.search');
			var panel = $('.search_panel');

			search.on('click', function()
			{
				panel.toggleClass('active');
			});
		}
	}

	/* 

	4. Init Menu

	*/

	function initMenu()
	{
		if($('.hamburger').length)
		{
			var hamb = $('.hamburger');

			hamb.on('click', function(event)
			{
				event.stopPropagation();

				if(!menuActive)
				{
					openMenu();
					
					$(document).one('click', function cls(e)
					{
						if($(e.target).hasClass('menu_mm'))
						{
							$(document).one('click', cls);
						}
						else
						{
							closeMenu();
						}
					});
				}
				else
				{
					$('.menu').removeClass('active');
					menuActive = false;
				}
			});

			//Handle page menu
			if($('.page_menu_item').length)
			{
				var items = $('.page_menu_item');
				items.each(function()
				{
					var item = $(this);

					item.on('click', function(evt)
					{
						if(item.hasClass('has-children'))
						{
							evt.preventDefault();
							evt.stopPropagation();
							var subItem = item.find('> ul');
						    if(subItem.hasClass('active'))
						    {
						    	subItem.toggleClass('active');
								TweenMax.to(subItem, 0.3, {height:0});
						    }
						    else
						    {
						    	subItem.toggleClass('active');
						    	TweenMax.set(subItem, {height:"auto"});
								TweenMax.from(subItem, 0.3, {height:0});
						    }
						}
						else
						{
							evt.stopPropagation();
						}
					});
				});
			}
		}
	}

	function openMenu()
	{
		var fs = $('.menu');
		fs.addClass('active');
		hambActive = true;
		menuActive = true;
	}

	function closeMenu()
	{
		var fs = $('.menu');
		fs.removeClass('active');
		hambActive = false;
		menuActive = false;
	}

	/* 

	5. Init Quantity

	*/

	function initQuantity()
	{
		// Handle product quantity input
		if($('.product_quantity').length)
		{
			var input = $('#quantity_input');
			var incButton = $('#quantity_inc_button');
			var decButton = $('#quantity_dec_button');

			var originalVal;
			var endVal;

			incButton.on('click', function()
			{
				originalVal = input.val();
				endVal = parseFloat(originalVal) + 1;
				input.val(endVal);
			var price1 = document.getElementsByClassName('cart_item_price1');
			var total1 = document.getElementsByClassName('cart_item_total1');
			var i1 = price1[0].innerText;
			total1[0].innerText = i1*endVal;
			totals[0].innerText = (parseInt(totals[0].innerText,10)+ parseInt(i1*1,10));
			totals2.innerText = (parseInt(totals2.innerText,10)+ parseInt(i1*1,10));
		
		});


			decButton.on('click', function()
			{
				originalVal = input.val();
				if(originalVal > 0)
				{
					endVal = parseFloat(originalVal) - 1;
					input.val(endVal);
					var price1 = document.getElementsByClassName('cart_item_price1');
					var total1 = document.getElementsByClassName('cart_item_total1');
					var i1 = price1[0].innerText;
					total1[0].innerText = i1*endVal;
					totals[0].innerText = (parseInt(totals[0].innerText,10) -parseInt(i1*1,10));
			
					totals2.innerText = (parseInt(totals2.innerText,10) -parseInt(i1*1,10));
				}
			});
			
			
			
		
		}
	}
	function initQuantityy()
	{
		// Handle product quantity input
		if($('.product_quantity').length)
		{
			var input = $('#quantity_input1');
			var incButton = $('#quantity_inc_button1');
			var decButton = $('#quantity_dec_button1');

			var originalVal;
			var endVal;

			incButton.on('click', function()
			{
				originalVal = input.val();
				endVal = parseFloat(originalVal) + 1;
				input.val(endVal);
				var price2 = document.getElementsByClassName('cart_item_price2');
			var total2 = document.getElementsByClassName('cart_item_total2');
			var i2 = price2[0].innerText;
			total2[0].innerText = i2*endVal;
			totals[0].innerText = (parseInt(totals[0].innerText,10)+ parseInt(i2*1,10));
			totals2.innerText = (parseInt(totals2.innerText,10)+ parseInt(i2*1,10));
				
			});

			decButton.on('click', function()
			{
				originalVal = input.val();
				if(originalVal > 0)
				{
					endVal = parseFloat(originalVal) - 1;
					input.val(endVal);
					
				var price2 = document.getElementsByClassName('cart_item_price2');
				var total2 = document.getElementsByClassName('cart_item_total2');
				var i2 = price2[0].innerText;
				total2[0].innerText = i2*endVal;
				totals[0].innerText = (parseInt(totals[0].innerText,10)- parseInt(i2*1,10));
				
				totals2.innerText = (parseInt(totals2.innerText,10)- parseInt(i2*1,10));
			
			}
			});
		}
	}
	function initQuantityyy()
	{
		// Handle product quantity input
		if($('.product_quantity').length)
		{
			var input = $('#quantity_input2');
			var incButton = $('#quantity_inc_button2');
			var decButton = $('#quantity_dec_button2');

			var originalVal;
			var endVal;

			incButton.on('click', function()
			{
				originalVal = input.val();
				endVal = parseFloat(originalVal) + 1;
				input.val(endVal);
				
				var price3 = document.getElementsByClassName('cart_item_price3');
			var total3 = document.getElementsByClassName('cart_item_total3');
			var i3 = price3[0].innerText;
			total3[0].innerText = i3*endVal;
			totals[0].innerText = (parseInt(totals[0].innerText,10)+ parseInt(i3*1,10));
			
			totals2.innerText = (parseInt(totals2.innerText,10)+ parseInt(i3*1,10));
			
			});

			decButton.on('click', function()
			{
				originalVal = input.val();
				if(originalVal > 0)
				{
					endVal = parseFloat(originalVal) - 1;
					input.val(endVal);
					
				var price3 = document.getElementsByClassName('cart_item_price3');
				var total3 = document.getElementsByClassName('cart_item_total3');
				var i3 = price3[0].innerText;
				total3[0].innerText = i3*endVal;
				totals[0].innerText = (parseInt(totals[0].innerText,10)- parseInt(i3*1,10));
				
				totals2.innerText = (parseInt(totals2.innerText,10)- parseInt(i3*1,10));
			
			}
			});	
		}
	}

});