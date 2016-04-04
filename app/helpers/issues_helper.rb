module IssuesHelper

  def create_issue_in_github(issue)
    github_issue = current_user.github.create_issue(current_repo, issue.title, issue.description)
    Rails.cache.delete("#{repo_name}/issues")
  end

  def add_issue_to_milestone(issue_numbers, milestone)
    issue_numbers.each do |issue_number|
       current_user.github.update_issue(current_repo, issue_number.to_i, :milestone => milestone)
    end
    Rails.cache.delete("#{repo_name}/issues")
  end

end
