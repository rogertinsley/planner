class IssuesController < ApplicationController

  def create
    issue = Issue.new(issue_params)
    github_issue = current_user.github.create_issue(current_repo, issue.title, issue.description)
    flash[:success] = "Issue created"
    redirect_to backlog_path
  end

  def update
    # Form data - could this be done nicer?
    issue_numbers = params["milestone_issues"]["issue_numbers"].reject { |c| c.empty? }
    milestone     = params["milestone_issues"]["milestone"].to_i

    # Update the GitHub issue to add it to the milestone
    issue_numbers.each do |issue_number|
       current_user.github.update_issue(current_repo, issue_number.to_i, :milestone => milestone)
    end

    flash[:success] = "Issue(s) assigned to milestone"
    redirect_to backlog_path
  end

  private

  def issue_params
    params.require(:issue).permit(:title, :description)
  end
end
