class ProjectsController < ApplicationController

  before_action :find_project, only: [:show, :edit, :update, :destroy, :upvote, :downvote]


  def index
    @projects = Project.paginate(page: params[:page], per_page: 10).search(params[:search])
  end

  def show
    session[:return_to] ||= request.referer
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      @project.vote = Vote.new
      redirect_to projects_path, notice: "Project created successfully"
    else
      flash.now[:alert] = "Problem creating project"
      render :new
    end
  end

  def edit
  end

  def update
    if @project.update_attributes(project_params)
      redirect_to @project, notice: "Project updated successfully"
    else
      flash.now[:alert] = "Problem updating project"
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path, notice: "Project deleted successfully"
  end

  def upvote
    @project.vote.up
    redirect_to projects_path(page: params[:page])
  end

  def downvote
    @project.vote.down
    redirect_to projects_path(page: params[:page])
  end

  private

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    puts params.inspect
    params.require(:project).permit(:title, :description, :due_date, :votes)
  end
end
