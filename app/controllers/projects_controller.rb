class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_project, only: [:show, :edit, :update, :destroy, :upvote, :downvote]


  def index
    @projects = Project.paginate(page: params[:page], per_page: 10).search(params[:search])
  end

  def show
    session[:return_to] ||= request.referer
    @done            = @project.tasks.where("status = true")
    @notdone         = @project.tasks.where("status = false")
    @task            = Task.new
    @users           = User.all
    @tags            = @project.tags
    @project_members = @project.project_members
    @favorite        = @project.favorites.where(user: current_user).first
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
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
    if current_user == @project.user
      if @project.update_attributes(project_params)
        redirect_to @project, notice: "Project updated successfully"
      else
        flash.now[:alert] = "Problem updating project"
        render :edit
      end
    else
      redirect_to @project, alert: "That's not yours buster >:("
    end
  end

  def destroy
    if current_user == @project.user
      @project.destroy
      redirect_to projects_path, notice: "Project deleted successfully"
    else
      redirect_to @project, alert: "That's not yours buster >:("
    end
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
    params.require(:project).permit(:title, :description, :due_date, :votes, {tag_ids: []})
  end
end
