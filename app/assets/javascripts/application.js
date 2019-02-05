// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require rails-ujs
//= require bootstrap-sprockets
//= require_tree .

  var toast = function(header, message) {
    var toast = document.createElement("div");
    toast = $(toast);
    toast.addClass('toast-wrapper');
    toast.html("<div class='toast-bg'></div><div class='toast'><div class='toast-header'>Elections Ontario PVC</div><div class='toast-body'><span class='toast-title'>"+header+"</span>"+message+"</div></div>")
    $(document.body).append(toast);
    return toast;
  }

  var showNotification = function(notifications) {
    // Show the first one, set up marking as shown if dismissed
    var notification = notifications[0];
    if (notification) {
      var t = toast(notification.title, notification.default_content)
      t.click(function(notification) {
        console.log("dismiss notification ID", notification.id)
        dismissNotification(notification.id).then(function() {
          //console.log("remove", this)
          window.location = "/notifications/" + notification.id
          //$(this).remove();
        }.bind(t))
      }.bind(t, notification))
    }
  }
  
  var dismissNotification = function(notificationId) {
    return $.ajax({
      url: "/notifications/"+notificationId+"/dismiss"
    })
  }

  var runCheck = function(userId) {
    if ($(".toast").length > 0) {
      return Promise.resolve();
    }
    return $.ajax({
      url: "/notifications/check_new?user_id=" + userId
    }).then(function(response) {
      console.log(response)
      showNotification(response.notifications);
      // Display any new notifications, marking them as displayed
    })
  }

  var checkInAppNotifications = function(userId) {
    $(document).ready(function() {
      runCheck(userId).then(function() {
        window.setTimeout(checkInAppNotifications.bind(this,userId), 1000)
      })    
    })
  }