class Public::ChatsController < ApplicationController
  # 相互フォローしてる人同士のみ
  before_action :follow_each_other, only: [:show]

  def index
    my_rooms_ids = current_user.user_rooms.select(:room_id)
    @user_rooms = UserRoom.includes(:chats, :user).where(room_id: my_rooms_ids).where.not(user_id: current_user.id).reverse_order
  end

  def show
    # どのユーザーとチャットするかを取得
    @user = User.find(params[:id])
    # current_userのuser_roomにあるroom_idの値を格納
    rooms = current_user.user_rooms.pluck(:room_id)
    # user_idがチャット相手のidに一致するものと、room_idがroomsのどれかに一致するレコードを格納
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    # もしuser_roomが空でないなら
    if user_rooms.nil?
      @room = Room.new
      @room.save
      # user_roomをカレントユーザーとチャット相手で分ける
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    else
      # user_roomsのroomを格納
      @room = user_rooms.room
    end

    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    room = Room.find(chat_params[:room_id])

    # チャット機能
    @visited_id = params[:chat][:visited_id]
    @room_id = @chat.room

    if @chat.save
      @chats = room.chats
      notification = current_user.active_notifications.new(
        room_id: @room_id.id,
        chat_id: @chat.id,
        visited_id: @visited_id,
        visitor_id: current_user.id,
        action: 'chat'
      )
      # 自分の投稿に対するチャットの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  def follow_each_other
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to posts_path
    end
  end
end
