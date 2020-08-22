class RoomChannel < ApplicationCable::Channel

  # クライアントとWebSocketがチャネルを通して関連付けられた後に呼ばれる（購読と呼ばれる）
  def subscribed
    stream_from "room_channel"
    # ここでroom_channelという接続している全購読用のストーリ名を設定
    # クライアント側にメッセージを送る際に使用
  end

  # 上の繋がりが解除後に呼ばれるメソッド
  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # クライアントから呼び出された時に呼ばれるメソッド
  def speak(data)
    puts "Hello This is room_channel.rb & speak method"
    puts "This is data : #{data}"
    message = Message.create(
        room_id: data["room_id"],
        user_id: data["user_id"],
        message: data["message"]
    )
    # ここでroom_channelにデータを送る
    ActionCable.server.broadcast(
        "room_channel",{ message: render_message(message) }
    )
  end

  private

  #　受け取ったメッセージを元にそのメッセージ用のHTMLを作成する
  def render_message(message)
    # ApplicationControllerならコントローラーからも使用できる
    ApplicationController.render(
        partial: "messages/message",
        locals: { message: message }
    )
  end

end
