class BacklogController < ApplicationController
  include BacklogHelper

  before_action :set_project, only: [:index]

  def index
    @issues     = fetch_issues
    @milestones = fetch_milestones
  end

  private
  def set_project
    @project = Project.find_by_repository(params[:repo])
  end

end
