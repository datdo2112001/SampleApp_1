# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def create; end

  def index
    participants = Participant.where(user_id: current_user.id)
    @rooms = participants.map(&:room)
  end
end
