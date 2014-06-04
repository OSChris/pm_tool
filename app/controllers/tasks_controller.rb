class TasksController < ApplicationController
  
  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)
    if @task.save
      redirect_to @project, notice: "Task successfully created"
    else
      flash.now[:alert] = "Problem with creating task"
      render "projects/show"
    end
  end

  ## def edit
  ## end

  def update
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    if @task.update_attributes(task_params)
      redirect_to @project, notice: "Task successfully updated"
    else
      redirect_to @project, alert: "Problem updating task."
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @task.destroy
    redirect_to @project, notice: "Task successfully deleted"
  end

  private

  ## def find_task
  ##   @task = Task.find(params[:id])
  ## end

  def task_params
    params.require(:task).permit(:title, :body, :due_date, :status)
  end

end
