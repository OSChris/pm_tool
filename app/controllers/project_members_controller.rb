class ProjectMembersController < ApplicationController

  before_action :authenticate_user!
  before_action :find_project

  def create
    @project_member      = @project.project_members.new
    @project_member.user = User.find params[:user_id]
    if @project_member.save
      redirect_to @project, notice: "Added #{@project_member.user.name_display}"
    else
      redirect_to @project, alert: "Problem adding user."
    end
  end

  def destroy
    @project_member = @project.project_members.find params[:id]
    if @project_member.destroy
      redirect_to @project, notice: "Removed #{@project_member.user.name_display}"
    else
      redirect_to @project, alert: "Problem removing user."
    end
  end

  private

  def find_project
    @project = Project.find params[:project_id]
  end

end
