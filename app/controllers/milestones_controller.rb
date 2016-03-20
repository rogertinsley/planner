class MilestonesController < ApplicationController

  def create
    milestone = Milestone.new(milestone_params)
    github_issue = current_user.github.create_milestone(current_repo, milestone.title, milestone.description, milestone.due_date)
    redirect_to backlog_path
  end

  private

  def milestone_params
    params.require(:milestone).permit(:title, :description, :due_date)
  end
end
