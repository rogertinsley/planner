class BacklogController < ApplicationController
  include BacklogHelper

  before_action :set_project, only: [:index]
  before_action :fetch_issues, only: [:index]
  before_action :fetch_milestones, only: [:index]

  def index
  end

  private
  def set_project
    @project = Project.find_by_repository(params[:repo])
  end

end
