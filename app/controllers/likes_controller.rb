class LikesController < ApplicationController
  def create
  	@like = current_user.likes.new(like_params)
  	if @like.save
  	  redirect_to @like.micropost
  	else
  	  flash[:notice] = @like.errors.full_messages.to_sentence
  	end
  end

  def destroy
  	@like = current_user.likes.find(params[:id])
  	micropost = @like.micropost
  	@like.destroy
  	redirect_to micropost
  end

  private
    def like_params
    	params.require(:like).permit(:micropost_id)
    end

end
