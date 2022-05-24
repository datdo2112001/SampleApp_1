# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :micropost

  belongs_to :user

  after_create_commit :notify_recipient

  default_scope -> { order(created_at: :desc) }
  validates :micropost_id, presence: true
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  private

  def notify_recipient
    CommentNotification.with(micropost: micropost, author: user.name).deliver_later(micropost.user)
  end
end
