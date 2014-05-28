class TasksController < ApplicationController
  
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Task successfully created"
    else
      flash.now[:alert] = "Problem with creating task"
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update_attributes(task_params)
      redirect_to @task, notice: "Task successfully updated"
    else
      flash.now[:alert] = "Problem updating task"
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Task successfully deleted"
  end

  private

  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :due_date)
  end

end
