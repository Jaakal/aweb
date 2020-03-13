function loadJavaScript() {
  $(".refresh-button").click(function(e) {
    e.preventDefault();
    ajaxCallToServer("GET", "/users/search", ".who-to-follow-results");
  }); 
  
  $(".index-posts-button").click(function(e) {
    e.preventDefault();
    $(".tab").removeClass("border-bottom");
    ajaxCallToServer("GET", "/microposts", ".main-content");
    $(".main-content").addClass("display-main-content");
    $(".index-posts-tab").addClass("border-bottom");
  });
  
  $(".show-posts-button").click(function(e) {
    e.preventDefault();
    $(".tab").removeClass("border-bottom");
    slug = window.location.href.substring(window.location.href.lastIndexOf("/"));
    ajaxCallToServer("GET", "/microposts" + slug, ".user-main-content");
    $(".user-main-content").addClass("display-user-main-content");
    $(".user-posts-tab").addClass("border-bottom");
  });
  
  $(".show-following-button").click(function(e) {
    e.preventDefault();
    $(".tab").removeClass("border-bottom");
    username = window.location.href.substring(window.location.href.lastIndexOf("/"));
    ajaxCallToServer("GET", "/users" + username + "/following", ".user-main-content");
    $(".user-main-content").addClass("display-user-main-content");
    $(".user-following-tab").addClass("border-bottom");
  });
  
  $(".show-followers-button").click(function(e) {
    e.preventDefault();
    $(".tab").removeClass("border-bottom");
    username = window.location.href.substring(window.location.href.lastIndexOf("/"));
    ajaxCallToServer("GET", "/users" + username + "/followers", ".user-main-content");
    $(".user-main-content").addClass("display-user-main-content");
    $(".user-followers-tab").addClass("border-bottom");
  });
  
  $(".dropdown-button").click(function(e) {
    e.preventDefault();
    $(".popup-menu").toggleClass("visible");
  });

  $(".post-submit-button").click(function(e) {
    e.preventDefault();
    $('input.text-field').removeClass("error");
    $('.text-field').attr("placeholder", "Compose a new post");
    
    $.ajax({
      url: '/microposts',
      type: 'post',
      data: { micropost: {text: $('.text-field').val() } },
      success: function(searchResult) {
        $('.text-field').val('');
        
        if (searchResult.includes('error')) {
          $('.text-field').attr("placeholder", searchResult.substring(5));
          $('input.text-field').addClass("error");
        } else {
          $(".main-content").html(searchResult);
          $(".posts").addClass("border-bottom");
          $(".main-content").addClass("display-main-content");
        }
    }});
  });
}

function ajaxCallToServer(action, url, elementSelector) {
  var xhttp;

  if (window.XMLHttpRequest) {
    // code for modern browsers
    xhttp = new XMLHttpRequest();
    } else {
    // code for IE6, IE5
    xhttp = new ActiveXObject("Microsoft.XMLHTTP");
  }

  xhttp.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      $(elementSelector).html(this.responseText);
    }
  };

  xhttp.open(action, url, true);
  xhttp.send();
}

document.addEventListener("turbolinks:load", function() {
  setTimeout(function() { loadJavaScript(); }, 0);
})

// window.onpopstate = function() {
//   setTimeout(function() { loadJavaScript(); }, 0);
// }