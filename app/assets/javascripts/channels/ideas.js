//= require cable
//= require_self

(function() {
  
    $(document).ready(function() {  
      App.ideas = App.cable.subscriptions.create('NotificationsChannel', {
        /**
         * Whenever this channel pushes content, it is received here
         */
        received: function(idea) {
          notifications.onReceiveNotification(idea);
          console.log (idea);
        }
      });
    });
  }).call(this);e