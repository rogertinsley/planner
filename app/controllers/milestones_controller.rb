class MilestonesController < ApplicationController

  def create

    # Create milestone
    milestone = Milestone.new(milestone_params)
    options = { :state => 'open', :description => milestone.description, :due_on => Time.parse(milestone.due_date) }
    current_user.github.create_milestone(current_repo, milestone.title, options)

    flash[:success] = "Milestone created"
    redirect_to backlog_path
  end

  private

  def milestone_params
    params.require(:milestone).permit(:title, :description, :due_date)
  end
end
