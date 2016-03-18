class IssuesController < ApplicationController

  def create
    issue = Issue.new(issue_params)
    github_issue = current_user.github.create_issue(current_repo, issue.title, issue.description)
    redirect_to backlog_path
  end

  private

    def issue_params
      params.require(:issue).permit(:title, :description)
    end
end
