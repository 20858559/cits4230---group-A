// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require angular.js
//= require bootstrap


function resetErrors(){
    if($('.messages').length){
        $('body').find('.messages').remove();
    }
}

var fade_flash = function() {
    $("#flash_notice").delay(5000).fadeOut("slow");
    $("#flash_alert").delay(5000).fadeOut("slow");
    $("#flash_error").delay(5000).fadeOut("slow");
};
fade_flash();

var show_ajax_message = function(msg, type) {
    if(type == 'notice'){
        $("#flash-messages").html('<div class="alert alert-success" id="flash_'+type+'">'+msg+'</div>');
    }
    else{
        $("#flash-messages").html('<div class="alert alert-error" id="flash_'+type+'">'+msg+'</div>');
    }
    
    fade_flash();
};

$(document).ready(function(){
    console.log("ready");

    //ajax errors
    $(document).ajaxError(function(e, jqxhr, settings, exception) {
        console.log(exception);
    });

    //success
    $("#flash-message").ajaxComplete(function(event, request) {
        
    });
});

