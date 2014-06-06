class DiscussionsController < ApplicationController
  
  before_action :authenticate_user!, except: [:index, :show]  
  before_action :find_project, only: [:show, :new, :index, :create, :edit, :update, :destroy]
  before_action :find_discussion, only: [:show, :edit, :update, :destroy]

  def index
    @discussions = @project.discussions
  end

  def show
    @comment = Comment.new
  end

  def new
    @discussion = @project.discussions.new
  end

  def create
    @discussion = @project.discussions.new(discussion_params)
    @discussion.user = current_user
    if @discussion.save
      redirect_to project_discussions_path(@project), notice: "Discussion successfully created!"
    else
      flash.now[:alert] = "Problem creating discussion"
      render :new
    end
  end

  def edit
    
  end

  def update
    if @discussion.update_attributes(discussion_params)
      redirect_to project_discussions_path(@project), notice: "Discussion successfully updated!"
    else
      flash.now[:alert] = "Problem updating discussion"
      render :edit
    end
  end

  def destroy
    @discussion.destroy
    redirect_to project_discussions_path, notice: "Discussion successfully destroyed."
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_discussion
    @discussion = @project.discussions.find(params[:id])
  end

  def discussion_params
    params.require(:discussion).permit(:title, :description)
  end

end
