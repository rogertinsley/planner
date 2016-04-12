class MilestonesController < ApplicationController

  def index
    @issues = Rails.cache.fetch("#{repo_name}/issues") do
      current_user.github.list_issues current_repo, { :milestone => "none" }
    end
    @milestones = Rails.cache.fetch("#{repo_name}/milestones") do
      current_user.github.list_milestones current_repo
    end
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
    @milestone = current_user.github.milestone(current_repo, params[:id])
  end

  private

  def milestone_params
    params.require(:milestone).permit(:title, :description, :due_date, :id)
  end
end
