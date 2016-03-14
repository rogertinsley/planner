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
      rescue => e
        # request didn't succeed because the token was revoked so we
        # invalidate the token stored in the session and render the
        # index page so that the user can start the OAuth flow again
        session[:access_token] = nil
        return authenticate!
      end

      client = Octokit::Client.new :access_token => access_token
      user = User.where(user_name: client.user.login).first_or_initialize
      user.avatar_url = client.user.avatar_url
      user.save
      session[:user] = user
      redirect_to '/'
    end
  end

  def create
    result = Octokit.exchange_code_for_token(params[:code], ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'])
    session[:access_token] = result[:access_token]
    user = User.where(user_name: client.user.login)
    user.token = result[:access_token]
    user.save
    redirect_to '/'
  end

  def destroy
    session[:access_token] = nil
  end
end
