class MilestonesController < ApplicationController
  include BacklogHelper

  before_action :fetch_issues, only: [:index, :show]
  before_action :fetch_milestones, only: [:index, :show]

  def index
  end

  def create
    # Create milestone
    milestone = Milestone.new(milestone_params)
    options = { :state => 'open', :description => milestone.description, :due_on => Time.parse(milestone.due_date) }
    current_user.github.create_milestone(current_repo, milestone.title, options)
    Rails.cache.delete("#{repo_name}/milestones")
    flash[:success] = "Milestone created"
    redirect_to backlog_path
  end

  def show
    milestone = params[:id]
    @milestone = current_user.github.milestone(current_repo, milestone)
    @issues_in_milestone = current_user.github.list_issues current_repo, { :milestone => milestone }
  end

  private

  def milestone_params
    params.require(:milestone).permit(:title, :description, :due_date, :id)
  end
end
