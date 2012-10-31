

var $name = "Banner";
var $email = "Schafer14@up.edu";


// Variables for albums table
// Image must be jpg
var albums = {};
addAlbum("Oregon Cost", "public/files/1/photos/1/medium/cmdb.png", albums);
addAlbum("Mary's Peak", "img/Ali & I.jpg", albums);
addAlbum("Sen10r Year", "img/Banner.jpg", albums);

var userAlbs = ["This Album " , "That", "And the other", "more"];



$(function(){

	/*/Makes albums
	for (alb in albums){
		var temp = alb;
		album = albums[temp];		
		var newHTML = '';
		newHTML = newHTML + '<div class="span4">';
		newHTML = newHTML + '<h2>'+album.name+'</h2>';
		newHTML = newHTML + '<a href="/photoUploadix/users/1/"><IMG style="WIDTH: 322px; HEIGHT: 240px" height=100 src="'+album.img+'" width=75 border=0></a>';
		newHTML = newHTML + '<a href="#" class="btn btn-primary btn-mini add"><i class="icon-black icon-plus-sign"></i> Add</a>';
		newHTML = newHTML + '<a href="#" class="btn btn-info btn-mini priv"><i class="icon-black icon-asterisk"></i> Set Private</a>';
		newHTML = newHTML + '<a href="#" class="btn btn-success btn-mini description"><i class="icon-black icon-align-left"></i> Description</a>';
		newHTML = newHTML + '<a href="#" class="btn btn-warning btn-mini like"><i class="icon-black icon-thumbs-up"></i> Like</a>';
		newHTML = newHTML + '<a href="#" class="btn btn-danger btn-mini delete"><i class="icon-black icon-fire"></i> Delete</a>';
		newHTML = newHTML + '</div>';
		$('#albums').append(newHTML);		
	}*/

       	$(document).on('click', '.description' , function(){
		var HTML = '';
		HTML = HTML +  ' <textarea rows="3">Add description</textarea><br><a href="#" class="btn btn-primary btn-mini"><i class="icon-white icon-ok"></i> Save</a> ';
		$(this).parent().append(HTML);
	    });

	$(document).on('click', '.add' , function(){
		window.location.replace("/photoUploadix/users/"+ 1 +"/photos/new");
	    });

	$(document).on('click', '.like' , function(){
		alert("photo LIKED :D");
		console.log($(this));
	    });

	$(document).on('click', '.priv' , function(){
		alert("picture is now private!");
	    });

	$(document).on('click', '.delete' , function(){
		var answer = confirm("Are you sure you want to delete?!?");
		if(answer){
		    alert("Image deleted");
		}
		else{
		    alert("Image saved");
		}
	    });

});

//Set binding for user table
function userInfo($scope){
	$scope.name = $name;
	$scope.email = $email;
}


//adds a video to an array
function addAlbum($name, $img, $array)
{
	var hashInfo = {};
	hashInfo.name = $name;
	hashInfo.img = $img;
	albums[$name] = hashInfo;
}


