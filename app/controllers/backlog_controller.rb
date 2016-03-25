class BacklogController < ApplicationController

  before_action :set_project, only: [:index]

  def index
    # https://api.github.com/repos/rogertinsley/g-maps/issues
    @issues = current_user.github.list_issues current_repo, { :milestone => "none" }
    @milestones = current_user.github.list_milestones current_repo
  end

  private
  def set_project
    @project = Project.find_by_repository(params[:repo])
  end

end
