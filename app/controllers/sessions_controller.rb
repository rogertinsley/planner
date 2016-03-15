class SessionsController < ApplicationController

  skip_before_filter :authorize

  def new
    if !authenticated?
      authenticate!
    else
      access_token = session[:access_token]
      client = Octokit::Client.new \
        :client_id => ENV['GITHUB_KEY'],
        :client_secret => ENV['GITHUB_SECRET']
      begin
        client.check_application_authorization access_token
        redirect_to root_url
      rescue => e
        # request didn't succeed because the token was revoked so we
        # invalidate the token stored in the session and render the
        # index page so that the user can start the OAuth flow again
        session[:access_token] = nil
        return authenticate!
      end
    end
  end

  def create
    result = Octokit.exchange_code_for_token(params[:code], ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'])

    # Set access_token
    session[:access_token] = result[:access_token]

    # Create user model and save
    client = Octokit::Client.new :access_token => session[:access_token]
    login  = client.user.login

    # Retrieve or create new user
    user = User.where(user_name: login).first_or_initialize

    # Set values
    user.avatar_url = client.user.avatar_url
    user.user_name  = client.user.login
    user.token      = result[:access_token]

    # Commit
    user.save

    redirect_to root_url
  end

  def destroy
    sign_out
  end
end
