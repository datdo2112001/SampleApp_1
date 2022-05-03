class CommentsController < ApplicationController
	before_action :authenticate_user!
  before_action :correct_user, only: :destroy
  
	def create
	  @current_micropost = Micropost.find(params[:micropost_id])
	  @comment = @current_micropost.comments.build(comment_params)
	  @comment.user = current_user
	  respond_to do |format|
      if @comment.save
        format.html { redirect_to @current_micropost, notice: 'Success!' }
        format.js   { }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
	end

	def destroy
		@comment.destroy
		flash[:success] = "Comment deleted"
    respond_to do |format|
      format.html { redirect_to request.referrer, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
      format.js   { render layout: false }
    end
	end

	private
	  def comment_params
	  	params.require(:comment).permit(:content)
	  end

	  def correct_user
	    @comment = current_user.comments.find_by(id: params[:id])
	    redirect_to root_url if @comment.nil?
	  end

end
