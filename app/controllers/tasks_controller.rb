class TasksController < ApplicationController
  
  before_action :authenticate_user!
  before_action :find_task, only: [:edit, :update]

  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)
    @task.user = current_user
    respond_to do |format|
      if @task.save
        flash.now[:notice] = "Task successfully created!"
        format.html { redirect_to @project, notice: "Task successfully created!" }
        format.js   { render }
      else
        flash.now[:alert] = "Problem with creating task" 
        format.html { render "projects/show" }
        format.js   { render }
      end
    end
  end

  def edit
    respond_to do |format|
      format.js { render }
    end
  end

  def update
    if current_user == @task.user
      respond_to do |format|
        if @task.update_attributes(task_params)
          format.html { redirect_to @project, notice: "Task successfully updated" }
          format.js   { render }
        else
          format.html { redirect_to @project, alert: "Problem updating task." }
          format.js   { render }
        end
      end
    else
      redirect_to @project, alert: "That's not yours buster >:("
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    respond_to do |format|
      if current_user == @task.user
        @task.destroy
        format.html { redirect_to @project, notice: "Task successfully deleted" }
        format.js   { render }
      else
        format.html { redirect_to @project, alert: "That's not yours buster >:(" }
        format.js   { render }
      end
    end
  end

  private

  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :body, :due_date, :status)
  end

end
