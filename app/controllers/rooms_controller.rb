class RoomsController < ApplicationController
  before_action :check_login

  def create
    puts "Hello This is Room Create Method"
    @user = User.find_by(id: params[:room][:user_id])
    room = current_user.room_exists?(@user) # [array] or False
    puts "This is @user.id #{@user.id}"
    puts "This is current_user.id #{current_user.id}"
    if room
      puts "ルームが存在しています。"
      # ここで既にルームが存在する場合
      @room_id = room[0] # ここでルームIDを取得する
      redirect_to room_path(@room_id)
    else
      puts "ルームはまだ存在していない"
      # ルームがまだ存在しない場合。RoomとEntry2つを作成する
      @room = Room.create
      ActiveRecord::Base.transaction do
        Entry.create(room_id: @room.id,user_id: current_user.id)
        Entry.create(room_id: @room.id,user_id: @user.id)
      end
      redirect_to room_path(@room)
    end
  end

  def show
    @room = Room.find_by(id: params[:id])
    @users = User.where("id IN (?)",Entry.where(room_id: @room).pluck(:user_id))
    @user = @users.where.not(id: current_user.id).first
    @messages = Message.where(room_id: @room.id).order(created_at: :asc)
  end

  private

  def check_login
    redirect_to root_url unless logged_in?
  end

end
