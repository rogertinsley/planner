class IssuesController < ApplicationController

  # POST /issues
  def create
    issue = Issue.new(issue_params)
    repo = { :repo => request.params[:repo], :owner => request.params[:owner] }
    github_issue = current_user.github.create_issue(repo, issue.title, issue.description)
    redirect_to backlog_path
  end

  private

    def issue_params
      params.require(:issue).permit(:title, :description)
    end
end
