module ApplicationHelper

  def current_repo
    @current_repo ||= { :repo => request.params[:repo], :owner => request.params[:owner] }
  end

end
