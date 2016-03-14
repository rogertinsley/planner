class User < ActiveRecord::Base

  def github
    unless @github.present?
      @github = Octokit::Client.new access_token: token
    end
    @github
  end
end
