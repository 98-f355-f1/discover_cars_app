class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :authorized
  before_action :store_request_params
  helper_method :logged_in?
  helper_method :current_user

  private

  def store_request_params
    return unless logged_in?

    headers = request.headers

    access_log = {
      url_path: headers['REQUEST_PATH'],
      ip_address: headers['REMOTE_ADDR'],
      user_agent: headers['HTTP_USER_AGENT'],
      method: headers['REQUEST_METHOD']
    }

    AccessLog.create(access_log)
  end
end
