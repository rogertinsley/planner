class BacklogController < ApplicationController

  before_action :set_project, only: [:index, :show]

  def index
    @issues = current_user.github.list_issues(current_repo).map{ |i| [ i.html_url, i.number, i.title ] }
  end

  private
  def set_project
    @project = Project.find_by_repository(params[:repo])
  end

end
