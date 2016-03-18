class ProjectsController < ApplicationController

  def index
    @repositories = current_user.github.repositories.map { |r| r[:full_name] }
    @projects = Project.all
  end

  def create
    project             = Project.create(project_params)
    project.owner       = project_params[:full_name].split('/').first
    project.repository  = project_params[:full_name].split('/').last
    project.save
    redirect_to root_path
  end

  private
    def project_params
      params.require(:project).permit(:full_name)
    end
end
