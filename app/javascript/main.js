function loadJavaScript() {
  $(".refresh-button").click(function(e) {
    e.preventDefault();
    loadNewUsersToFollowList();
  }); 
  
  // $(".posts-button").click(function(e) {
  //   e.preventDefault();
  //   $.ajax({url: "http://localhost:3000/microposts", success: function(searchResult){
  //     $(".main-content").html(searchResult);
  //     $(".main-content").addClass("display-main-content");
  //     $(".posts").addClass("border-bottom");
  //   }});
  // });
  
  $(".dropdown-button").click(function(e) {
    e.preventDefault();
    $(".popup-menu").toggleClass("visible");
  });
  
  // $(".micropost").bind("ajax:complete", function(event, xhr, status) {
  //   $('.text-field').val('');

  //   $.ajax({url: "http://localhost:3000/microposts", success: function(searchResult){
  //     $(".main-content").html(searchResult);
  //     $(".main-content").addClass("display-main-content");
  //   }});
  // });
}

function loadNewUsersToFollowList() {
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
      $(".who-to-follow-results").html(this.responseText);
    }
  };

  xhttp.open("GET", "http://localhost:3000/users/search", true);
  xhttp.send();
}

function ajaxCallToServer() {
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
      document.getElementById("demo").innerHTML = this.responseText;
    }
  };

  xhttp.open("GET", "ajax_info.txt", true);
  xhttp.send();
}

document.addEventListener("turbolinks:load", function() {
  setTimeout(function() { loadJavaScript(); }, 0);
})

window.onpopstate = function() {
  setTimeout(function() { loadJavaScript(); }, 0);
}