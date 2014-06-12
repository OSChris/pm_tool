class FavoritesController < ApplicationController

  before_action :find_project, except: [:index]
  before_action :authenticate_user!

  def index
    @favorites = current_user.favorite_projects
  end

  def create
    @favorite = @project.favorites.new
    @favorite.user = current_user
    if @project.user != current_user
      @favorite.save
      redirect_to @project, notice: "I love that project too!"
    else
      redirect_to @project, alert: "Couldn't favorite"
    end
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    if @favorite.destroy
      redirect_to @project, notice: "I didn't like that project anyway"
    else
      redirect_to @project, alert: "Couldn't unfavorite that"
    end
  end

  private

  def find_project
    @project = Project.find params[:project_id]
  end

end
