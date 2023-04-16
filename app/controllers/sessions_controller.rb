require 'uri'

class SessionsController < ApplicationController
  skip_before_action :authorized, only: %i[new create welcome]

  def new; end

  def create
    user = User.find_by(username: params[:session][:username])

    render 'new' and return unless user&.authenticate(params[:session][:password])

    log_in(user)

    refered_uri = session[:original_fullpath] if RouteChecker.path?(session[:original_fullpath])

    redirect_to refered_uri || '/welcome'
  end

  def welcome; end
end
