function loadJavaScript() {
  $(".refresh-button").click(function(e) {
    console.log("Hola");
    e.preventDefault();
    $.ajax({url: "http://localhost:3000/users/search", success: function(searchResult){
      $(".who-to-follow-results").html(searchResult);
    }});
  }); 
  
  $(".posts-button").click(function(e) {
    e.preventDefault();
    $.ajax({url: "http://localhost:3000/microposts", success: function(searchResult){
      $(".main-content").html(searchResult);
      $(".main-content").addClass("display-main-content");
      $(".posts").addClass("border-bottom");
    }});
  });
  
  $(".dropdown-button").click(function(e) {
    e.preventDefault();
    $(".popup-menu").toggleClass("visible");
  });
  
  $(".micropost").bind("ajax:complete", function(event, xhr, status) {
    $('.text-field').val('');
    
    $.ajax({url: "http://localhost:3000/microposts", success: function(searchResult){
      $(".main-content").html(searchResult);
      $(".main-content").addClass("display-main-content");
    }});
  });
}

document.addEventListener("turbolinks:load", function() {
  setTimeout(function() { loadJavaScript(); }, 0);
})

window.onpopstate = function() {
  setTimeout(function() { loadJavaScript(); }, 0);
}