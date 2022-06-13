# frozen_string_literal: true

# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(post: @post).deliver(current_user)

class CommentNotification < Noticed::Base
  deliver_by :database
  # deliver_by :email, mailer: "NotificationMailer", method: :comment_notification
  deliver_by :action_cable, channel: NotificationsChannel, stream: :custom_stream, format: :action_cable_data

  # Add required params
  param :micropost
  param :author

  # Define helper methods to make rendering easier.
  def message
    " #{params[:author]} comment on you post"
  end

  def url
    micropost_path(params[:micropost])
  end

  def custom_stream
    @micropost = params[:micropost]
    @micropost.user
  end

  def action_cable_data
    {
      text: "You have new comment on your post from #{params[:author]}"
    }
  end
end
