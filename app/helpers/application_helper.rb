module ApplicationHelper
  def github
    unless @github.present?
      token = session[:access_token]
      @github = Octokit::Client.new access_token: token
    end
    @github
  end
end
