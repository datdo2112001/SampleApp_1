# frozen_string_literal: true

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.find(params[:message][:chatroom_id])
    @receiver = User.find(params[:message][:receiver])
    @message = @room.messages.build(message_params)
    @message.user = current_user
    respond_to do |format|
      if @message.save
        format.html { redirect_to @room, notice: 'Success!' }
        format.js   {}
        format.json { render :show, status: :created, location: @message }
        ChatsChannel.broadcast_to(
          @receiver,
          {
            sent_by: current_user.name,
            body: @message.content
          }
        )
      else
        format.html { render root_path }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
