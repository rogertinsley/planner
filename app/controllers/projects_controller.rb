class ProjectsController < ApplicationController

  def index
    @repositories = current_user.github.repositories.map { |r| r[:full_name] }
    @projects = Project.all
  end

  def create
    Project.create(project_params)
    redirect_to root_path
  end

  private
    def project_params
      params.require(:project).permit(:github_repository)
    end
end
