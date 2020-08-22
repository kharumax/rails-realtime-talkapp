import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {

  // 接続された時に呼ばれるメソッド
  connected() {
    document.
        querySelector('input[data-behavior="room_speaker"]').
        addEventListener("keypress",(event) => {
          if (event.key === "Enter") {
            const data = {
              room_id: get_room_id(),
              user_id: get_user_id(),
              message: event.target.value
            };
            this.speak(data);
            event.target.value = '';
            return event.preventDefault();
          }
    });
    function get_room_id() {
      return document.querySelector("#room-id").value
    }
    function get_user_id() {
      return document.querySelector("#user-id").value
    }

  },

  // 切断時に呼ばれるメソッド
  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  // サーバーからのデータを受信した時に呼ばれるメソッド
  received(data) {
    console.log("HELLO This is received method!");
    const element = document.querySelector("#messages");
    element.insertAdjacentHTML("beforeend",data["message"])
  },

  // ここでサーバー側のspeakメソッドを呼んている
  speak: function(data) {
    return this.perform('speak',{
      room_id: data["room_id"],
      user_id: data["user_id"],
      message: data["message"]
    });
  }
});
