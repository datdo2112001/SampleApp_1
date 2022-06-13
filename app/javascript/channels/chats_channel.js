import consumer from "./consumer"

consumer.subscriptions.create("ChatsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("chat connected!")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    document.getElementById("myForm").style.display = "block";
    document.getElementById("myForm1").style.display = "block";
    document.getElementById("chatbox").style.display = "block";
    $(".message").append("p" + data["sent_by"] + ": " + data["body"] + "/p");
  }
});
