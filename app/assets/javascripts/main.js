function sessions_news(){
	
}

function projects_new(){
   // partner_ids = {}
   $("#project_partner_ids").tokenInput("/admin/organizations/json_names", {
     searchingText: 'cerco...',
     noResultsText: 'nessun risultato',
     hintText: 'Comincia a scrivere il nome del partner'
   });
   $("#project_external_partner_ids").tokenInput("/admin/external_organizations/json_names", {
     searchingText: 'cerco...',
     noResultsText: 'nessun risultato',
     hintText: 'Comincia a scrivere il nome del partner istituzionale'
   });
   
   $('input.ui-date-picker').datepicker( $.datepicker.regional[ "fr" ] );
   count_textarea()
   
}

function workshops_new(){

  $("#workshop_workshop_partner_ids").tokenInput("/admin/organizations/json_names", {
    searchingText: 'cerco...',
    noResultsText: 'nessun risultato',
    hintText: 'Comincia a scrivere il nome del partner'
  });
  
  $('input.ui-date-picker').datepicker( $.datepicker.regional[ "fr" ] );
  count_textarea()
}

var workshops_update = workshops_new
var workshops_edit = workshops_new
var workshops_create = workshops_new

var projects_create = projects_new
var projects_edit = projects_new
var projects_update = projects_new

function organizations_edit_external_partners(){
  // $("#organization_password").val("")
   $("#organization_external_partner_ids").tokenInput("/admin/external_organizations/json_names", {
     searchingText: 'cerco...',
     noResultsText: 'nessun risultato',
     hintText: 'Comincia a scrivere il nome del partner istituzionale'
   });
} 

function events_new(){
  
  // partner_ids = {}
  $("#event_event_partner_ids").tokenInput("/admin/organizations/json_names", {
    searchingText: 'cerco...',
    noResultsText: 'nessun risultato',
    hintText: 'Comincia a scrivere il nome del partner'
  });  
  
  count_textarea()
  $('input.ui-date-picker').datepicker( $.datepicker.regional[ "fr" ] );
}

var events_create = events_new
var events_edit = events_new
var events_update = events_new


function posts_new(){
  count_textarea()
  $('input.ui-date-picker').datepicker( $.datepicker.regional[ "fr" ] );
}

var posts_create   = posts_new
var posts_edit     = posts_new
var posts_update   = posts_new


function projects_show(){
      // $(document).ready(function(){

		$('#slider').hide().fadeIn('slow');
				
		$('#slider').bxSlider({
			        infiniteLoop: false,
			        speed: 600,
			        auto: ($(".bxslider>li").length > 1) ? true: false,
			        controls: false,
			        pager: true,
			        autoDelay: 1000,
			        pause: 5000,
			        mode: 'horizontal'
			      }).goToFirstSlide()
			
  // });
}



var workshops_show = projects_show
var organizations_show = projects_show

function organizations_edit(){
  count_textarea()
}

var organizations_update = organizations_edit


function home_index() {
  $(document).ready(function(){
    $('.bxslider').bxSlider({
      auto: ($(".bxslider>li").length > 1) ? true: false,
    });
  });
}

var events_index = home_index


// function events_new(){
//    // partner_ids = {}
//    $("#event_projectid").tokenInput("/admin/projects/json_names", {
//      searchingText: 'cerco...',
//      noResultsText: 'nessun risultato',
//      hintText: 'Comincia a scrivere il nome del progetto'
//    });
// }



function count_textarea(){
	  $(".countit").prepend("<span id='countit_counter'>caratteri rimasti: <span></span></span>");
	  
	  var cmax = $(".countit textarea").attr("counter");
	  $("#countit_counter span").text(cmax - $(".countit textarea").val().length);
	  
  	$(".countit textarea").keyup(function () {
      
      if ($(this).val().length >= cmax) {
        $(this).val($(this).val().substr(0, cmax));
      }
      $("#countit_counter span").text(cmax - $(this).val().length);
    });  
 
}



$(function() { 

	var funcName = $('body').attr('id');
	if (eval("typeof " + funcName + " == 'function'")) eval(funcName + '()');
	
	$('a.submit').click(function(){
    $('form.main').submit();
    return false;
  });
	
	
  // counter per campi limitati
	$(document).ready(function(){
	  

  });
	
	
});


$(window).load(function(){
	$(".square_logo img").each(function() {
    	image_height = $(this).height();
    	image_width = $(this).width();
    	margin_top = (140 - image_height) / 2;
    	margin_left = (140 - image_width) / 2;
    	$(this).css('margin-top', margin_top + 'px');
    	$(this).css('margin-left', margin_left + 'px');
    });
})

$(window).load(function(){
	$(".square_logo.micro img").each(function() {
    	image_height = $(this).height();
    	image_width = $(this).width();
    	margin_top = (40 - image_height) / 2;
    	margin_left = (40 - image_width) / 2;
    	$(this).css('margin-top', margin_top + 'px');
    	$(this).css('margin-left', margin_left + 'px');
    });
})

$(window).load(function(){
	$(".square_logo.small img").each(function() {
    	image_height = $(this).height();
    	image_width = $(this).width();
    	margin_top = (60 - image_height) / 2;
    	margin_left = (60 - image_width) / 2;
    	$(this).css('margin-top', margin_top + 'px');
    	$(this).css('margin-left', margin_left + 'px');
    });
})


$(window).load(function(){
	$(".organization_element img").each(function() {
    	image_height = $(this).height();
    	image_width = $(this).width();
    	margin_top = (220 - image_height) / 2;
    	margin_left = (220 - image_width) / 2;
    	$(this).css('margin-top', margin_top + 'px');
    	$(this).css('margin-left', margin_left + 'px');
    });
})



$(document).ready(function(){
 
});