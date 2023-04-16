module SessionsHelper
  attr_reader :request_uri

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id])
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user?(user)
    user == current_user
  end

  def authorized
    session[:original_fullpath] = request.original_fullpath
    redirect_to login_path unless logged_in?
  end
end
