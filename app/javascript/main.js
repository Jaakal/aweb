$(document).ready(function() {
  $(".refresh-button").click(function(e) {
    e.preventDefault();
    
    $.ajax({url: "http://localhost:3000/users/search", success: function(searchResult){
        $(".who-to-follow-results").html(searchResult);
    }});
  }); 
});