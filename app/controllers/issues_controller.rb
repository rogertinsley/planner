class IssuesController < ApplicationController

  # POST /issues
  def create
    issue = Issue.new(issue_params)
    repo = { :repo => issue.repo, :owner => issue.owner }
    github_issue = current_user.github.create_issue(repo, issue.title, issue.description)
    redirect_to backlog_path
  end

  private

    def issue_params
      params.require(:issue).permit(:title, :description, :owner, :repo)
    end
end
