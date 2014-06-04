class DiscussionsController < ApplicationController
    
  before_action :find_project, only: [:show, :new, :index, :create, :update, :destroy]

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
  end

  def update
  end

  def destroy
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def discussion_params
    params.require(:discussion).permit(:title, :description)
  end

end
