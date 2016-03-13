module SessionsHelper

  def authenticated?
    session[:access_token]
  end

  def authenticate!
   client = Octokit::Client.new
   url = client.authorize_url ENV['GITHUB_KEY'], :scope => 'user:email, repo'
   redirect_to url
  end

  def authorize
    if !signed_in?
      redirect_to '/login'
    end
  end

  def signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= begin
      session[:user]
    end
  end

end
