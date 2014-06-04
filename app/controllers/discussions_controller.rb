class DiscussionsController < ApplicationController
    
  before_action :find_project, only: [:show, :new, :index, :create, :edit, :update, :destroy]

  def index
    @discussions = @project.discussions
  end

  def show
    @discussion = Discussion.find(params[:id])
  end

  def new
    @discussion = @project.discussions.new
  end

  def create
    @discussion = @project.discussions.new(discussion_params)

    if @discussion.save
      redirect_to project_discussions_path(@project), notice: "Discussion successfully created!"
    else
      flash.now[:alert] = "Problem creating discussion"
      render :new
    end
  end

  def edit
    @discussion = @project.discussions.find(params[:id])
  end

  def update
    @discussion = @project.discussions.find(params[:id])
    if @discussion.update_params(discussion_params)
      redirect_to project_discussions_path(@project), notice: "Discussion successfully updated!"
    else
      flash.now[:alert] = "Problem updating discussion"
      render :edit
    end
  end

  def destroy
    @discussion = @project.discussions.find(params[:id])
    @discussion.destroy
    redirect_to project_discussions_path, notice: "Discussion successfully destroyed."
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def discussion_params
    params.require(:discussion).permit(:title, :description)
  end

end
