class ProjectsController < ApplicationController

  before_action :find_project, only: [:show, :edit, :update, :destroy]


  def index
    if params[:page].to_i > 0
      @page = params[:page].to_i
    else
      @page = 0
    end
    @pages=
    if Project.count % 10 == 0
      (Project.count) / 10 
    else
      ((Project.count) / 10) + 1
    end
    @total_projects = Project.all
    @projects = Project.search(params[:search]).offset(@page.to_i * 10)
  end

  def page_flip
    increment_page
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
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

  private

  def increment_page
    @page += 1 if @page < @pages
  end

  def find_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :due_date)
  end
end
