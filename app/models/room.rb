# frozen_string_literal: true

class Room < ApplicationRecord
  validates :name, length: { maximum: 50 }, uniqueness: true
  has_many :participants, dependent: :destroy
  has_many :messages, dependent: :destroy
end
