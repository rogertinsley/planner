class BacklogController < ApplicationController

  before_action :set_project, only: [:show]

  def show
  end

  private
  def set_project
    @project = Project.find_by_repository(params[:repo])
  end

end
