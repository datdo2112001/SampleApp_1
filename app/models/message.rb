# frozen_string_literal: true

class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  default_scope -> { order(created_at: :asc) }
end
