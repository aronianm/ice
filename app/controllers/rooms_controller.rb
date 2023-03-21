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
    if current_user.is_trainor
      @requested = RequestChat.where(:trainor_id => current_user.id, accepted: nil)

      @requested.each do |request|
        @rooms.push(Room.new(:name => "Request from #{request.user.name}", user_id: request.user_id, trainor_id: current_user.id))
      end
    end
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

  def accept_room_modal
    @user = params[:user_id]
  end

  def accept_room
    request = RequestChat.find_by(:trainor_id => current_user.id, accepted: nil, user_id: params[:user_id])
    request.accepted = params[:accepted]
    request.save
    if request.accepted
        uniq_key_time = DateTime.now.readable_inspect.gsub(" ", "_")
        Room.create(:name => "#{current_user.id}_#{params[:user_id]}_#{uniq_key_time}", user_id: request.user_id, trainor_id: current_user.id)
    end
    render :json => {:ok => '200'}
  end

  private

  def set_room
    @current_user = current_user
    @room = Room.find(params[:id])
  end

  def set_rooms
     if current_user.has_role?(:admin) 
      @rooms = Room.where("trainor_id = #{current_user.id} or user_id = #{current_user.id}").load.to_a
    elsif current_user.is_user
      @rooms = Room.where(:user_id => current_user.id).load.to_a
    else
      @rooms = Room.where(:trainor_id => current_user.id).load.to_a
    end
  end
end