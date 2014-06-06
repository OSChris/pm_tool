module ProjectsHelper

  def user_project_checker
    @project.user == current_user
  end
  
end
