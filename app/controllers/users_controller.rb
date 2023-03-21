class UsersController < ApplicationController
  def index
  end

  def request_modal
   @trainor = User.find(params[:user_id])
  end

  def request_send
    @user_trainor = UserTrainor.new(
      :user_id => current_user.id, :trainor_id => params[:user_id]
      )
      @user_trainor.save
      @save = @user_trainor.valid?
      @message = "#{@user_trainor.errors.full_messages.join(", ")}"
  end
  def pre_accept
      @user = User.find(params[:id])
  end

  def accept
      user = User.find(params[:id])
      acceptance = UserTrainor.find_by(:user_id => user.id, trainor_id: current_user.id)
      acceptance.accepted  = params[:accepted]
      acceptance.save
      @data = {redirect_to: nil, message: ""}
      
      if acceptance.accepted
        @data[:accepted] = true
        @data[:redirect_to] = users_trainor_path(user)
        flash[:notice] = "Congratulations, you are now all set to connect to talk to your client"
      else
        @data[:accepted] = false
        @data[:redirect_to] = nil
        @data[:message] = "You have declined user"
      end
  end

  def request_chat
    @trainor = User.find(params[:user_id])
    @request = RequestChat.find_by(:user_id => current_user.id, :trainor_id => @trainor.id)
    if @request
      @message = "Already requested a message with #{@trainor.name}"
    else
      @save = true
       @message = "Request for chat started with #{@trainor.name}"
      RequestChat.create(:user_id => current_user.id, trainor_id: @trainor.id, accepted: nil)
    end
    
  end

  def profile
    @user = User.find(params[:id])
    respond_to do |format|
      format.html{
        render layout: false
      }
    end
  end
end