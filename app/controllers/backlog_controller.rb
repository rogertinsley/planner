class BacklogController < ApplicationController

  before_action :set_project, only: [:index]

  def index
    # https://api.github.com/repos/rogertinsley/g-maps/issues
    @issues = Rails.cache.fetch("#{repo_name}/issues") do
      current_user.github.list_issues current_repo, { :milestone => "none" }
    end
    @milestones = Rails.cache.fetch("#{repo_name}/milestones") do
      current_user.github.list_milestones current_repo
    end
  end

  private
  def set_project
    @project = Project.find_by_repository(params[:repo])
  end

end
