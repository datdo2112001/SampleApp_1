# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!

  def show; end

  def create; end

  def index
    @rooms = []
    participants = Participant.all
    participants.each do |p|
      @rooms.push(p.room) if p.user_id == current_user.id
    end
  end
end
