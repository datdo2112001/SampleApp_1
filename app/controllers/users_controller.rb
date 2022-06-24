# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @chatroom = Room.find_by('name = ? OR name = ?', "#{current_user.name}-#{@user.name}",
                             "#{@user.name}-#{current_user.name}")
    unless @chatroom.persisted?
      @chatroom = Room.new(name: "#{current_user.name}-#{@user.name}")
      @chatroom.save
      Participant.create(user_id: current_user.id, room_id: @chatroom.id)
      Participant.create(user_id: @user.id, room_id: @chatroom.id)
    end
    @messages = @chatroom.messages
    @message = @chatroom.messages.build
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'Edit Successful.'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  def following
    @title = 'Following'
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Followers'
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
