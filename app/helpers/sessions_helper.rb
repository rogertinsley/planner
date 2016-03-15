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
    @current_user ||= session[:access_token] && User.find_by_token(session[:access_token])
  end

  def sign_out
    @current_user = session[:access_token] = nil
    redirect_to root_url
  end
end
