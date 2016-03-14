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
     User.find_by_user_name(session[:user_name]) if session[:user]['user_name']
    end
  end

  def sign_out
    session[:access_token] = nil
    reset_session
  end
end
