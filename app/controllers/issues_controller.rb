class IssuesController < ApplicationController
    include IssuesHelper

  def create
    create_issue_in_github(Issue.new(issue_params))

    flash[:success] = "Issue created"
    redirect_to backlog_path
  end

  def update
    # Form data - could this be done nicer?
    issue_numbers = params["milestone_issues"]["issue_numbers"].reject { |c| c.empty? }
    milestone     = params["milestone_issues"]["milestone"].to_i

    # Update the GitHub issue to add it to the milestone
    add_issue_to_milestone(issue_numbers, milestone)

    flash[:success] = "Issue(s) assigned to milestone"
    redirect_to backlog_path
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :description)
  end
end
