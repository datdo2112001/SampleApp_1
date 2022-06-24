# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @room = Room.find(params[:id])
    @user = Participant.where(room_id: @room.id).where.not(user_id: current_user.id).take.user
    @messages = @room.messages
    @message = @room.messages.build
  end

  def create; end

  def index
    participants = Participant.where(user_id: current_user.id)
    @rooms = participants.map(&:room)
  end
end
