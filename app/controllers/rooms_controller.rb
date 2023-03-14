class RoomsController < ApplicationController
  before_action :set_room, only: [:show]
  before_action :set_rooms, except: [:new, :destroy]
  def new
    uniq_key_time = DateTime.now.readable_inspect.gsub(" ", "_")
    @room = Room.create(:is_private => true, name: "#{current_user.id}_#{params[:user_id]}_#{uniq_key_time}", user_id: current_user.id, trainor_id: params[:user_id])
    
    @message = Message.new(:user_id => current_user.id, :room_id => @room)
    redirect_to room_path @room
  end

  def index
  end

  def show
    if current_user.is_user
      @rooms = Room.where(:user_id => current_user.id)
    else
      @rooms = Room.where(:trainor_id => current_user.id)
    end
    @talking_to = @room.talking_to(current_user)
    @user_connection = current_user.user_trainors.detect{|t| t.trainor_id == @talking_to.id}
    @messages = @room.messages
    @message = Message.new(:user_id => current_user.id, :room_id => @room)

    render "index"
  end

  def trainor_connect
    @room = Room.find_by(:trainor_id => params[:user_id], :user_id => current_user.id)
    @rooms = Room.where(:user_id => current_user.id)
    @messages = @room.messages
    @message = Message.new(:user_id => current_user.id, :room_id => @room)
    render "index"
  end

  def destroy
    room = Room.find(params[:id])
    room.messages.map(&:delete)
    room.delete
    redirect_to rooms_path
  end

  private

  def set_room
    @current_user = current_user
    @room = Room.find(params[:id])
  end

  def set_rooms
     if current_user.has_role?(:admin) 
      @rooms = Room.where("trainor_id = #{current_user.id} or user_id = #{current_user.id}")
    else
      @rooms = Room.where(:trainor_id => current_user.id)
    end
  end
end