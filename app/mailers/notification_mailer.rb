# frozen_string_literal: true

class NotificationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def comment_notification
    @post = params[:micropost]
    @url  = "http://127.0.0.1:3000/microposts/#{@post.id}"
    @author = params[:author]
    mail(to: @post.user.email, subject: 'You have new comment in your post !')
  end
end
