class SessionsController < ApplicationController

  def new
    if !authenticated?
        authenticate!
      else
        access_token = session[:access_token]
        scopes = []

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
        data = client.user
      end
  end

  def create
    result = Octokit.exchange_code_for_token(params[:code], ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'])
    session[:access_token] = result[:access_token]
    redirect_to '/'
  end

  def destroy
    session[:access_token] = nil
  end

  private

  def authenticated?
    session[:access_token]
  end

  def authenticate!
   client = Octokit::Client.new
   url = client.authorize_url ENV['GITHUB_KEY'], :scope => 'user:email, repo'
   redirect_to url
  end
end
