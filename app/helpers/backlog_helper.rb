module BacklogHelper

  def mark_button_as_primary(link_text, link_path)
    class_name = current_page?(link_path) ? 'btn btn-primary' : 'btn btn-default'
    link_to(link_text, link_path, class: class_name)
  end

  def fetch_issues
    @issues = Rails.cache.fetch("#{repo_name}/issues") do
      current_user.github.list_issues current_repo, { :milestone => "none" }
    end
  end

  def fetch_milestones
    @milestones = Rails.cache.fetch("#{repo_name}/milestones") do
      current_user.github.list_milestones current_repo
    end
  end

end
