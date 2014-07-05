class CommentsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :get_discussion
  before_action :get_comment, except: [:create]

  def create
    @comment = @discussion.comments.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to project_discussion_path(@discussion.project, @discussion), notice: "Comment posted!" }
        format.js   { render }
      else
        format.html { redirect_to project_discussion_path(@discussion.project, @discussion), alert: "Comment create failed :(" }
        format.js   { render }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html { render :edit}
      format.js   { render }
    end
  end

  def update
    respond_to do |format|
      if current_user == @comment.user
        if @comment.update_attributes(comment_params)
          format.html { redirect_to project_discussion_path(@discussion.project, @discussion), notice: "Comment updated." }
          format.js   { render }
        else
          flash.now[:alert] = "Problem editing comment"
          format.html { render :edit }
          format.js   { render }
        end
      else
        format.html { redirect_to project_discussion_path(@discussion.project, @discussion), alert: "That's not yours buster" }
      end
    end
  end

  def destroy
    respond_to do |format|
      if current_user == @comment.user
        @comment.destroy
        format.html { redirect_to project_discussion_path(@discussion.project, @discussion), notice: "Comment deleted." }
        format.js   { render }
      else
        format.html { redirect_to project_discussion_path(@discussion.project, @discussion), alert: "That's not yours buster" }
        format.js   { render }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def get_discussion
    @discussion = Discussion.find params[:discussion_id]
  end

  def get_comment
    @comment = @discussion.comments.find params[:id]
  end
end
