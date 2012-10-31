
$(document).ready( function() {

    $("#uploadPhotoForm").validateOnBlur();
    Galleria.loadTheme('/assets/galleria.classic.min.js');
    /*
    $('#user-gallery').galleria({
        extend: function() {
                this.bind(Galleria.LOADFINISH, function(e) {
                        $(e.imageTarget).click(this.proxy(function(e) {
                                e.preventDefault(); // removes the garbage
                                var obj = this.getData();
                                  $.fancybox({
                                        'href': obj.big,
                                        'title': obj.title,
                                        'titlePosition' : "inside"
                                        
                                        
                                });
                                
                        }))
                });
        }
    });
    */
    Galleria.run('#user-gallery');

 });