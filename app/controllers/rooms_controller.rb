class RoomsController < ApplicationController
  before_action :set_room, only: [:show]
  def new
    uniq_key_time = DateTime.now.readable_inspect.gsub(" ", "_")
    # @room = Room.create(:is_private => true, name: "#{current_user.id}_#{params[:user_id]}_#{uniq_key_time}", user_id: current_user.id, trainor_id: params[:user_id])
    @room = Room.first
    @message = Message.new(:user_id => current_user.id, :room_id => @room)
  end

  def index
    if current_user.has_role?(:admin) 
      @rooms = Room.where("trainor_id = #{current_user.id} or user_id = #{current_user.id}")
    else
      @rooms = Room.where(:trainor_id => current_user.id)
    end

  end

  def show
    @rooms = Room.where(:trainor_id => current_user.id)
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

  private

  def set_room
    @current_user = current_user
    @room = Room.find(params[:id])
  end
end