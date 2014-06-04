class CommentsController < ApplicationController
  
  before_action :get_discussion
  before_action :get_comment, except: [:create]

  def create
    @comment = @discussion.comments.new(comment_params)
    if @comment.save
      redirect_to project_discussion_path(@discussion.project, @discussion), notice: "Comment posted!"
    else
      redirect_to project_discussion_path(@discussion.project, @discussion), alert: "Comment create failed :("
    end
  end

  def edit
  end

  def update
    if @comment.update_attributes(comment_params)
      redirect_to project_discussion_path(@discussion.project, @discussion), notice: "Comment updated."
    else
      flash.now[:alert] = "Problem editing comment"
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to project_discussion_path(@discussion.project, @discussion), notice: "Comment deleted."
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
