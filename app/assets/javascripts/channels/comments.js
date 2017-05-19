App.comments = App.cable.subscriptions.create("CommentsChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
    console.log('connected');
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
    console.log('disconnected');
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('received: ');
    console.log(data);
    document.getElementById('comments').innerHTML += data.comment;
  }
});
