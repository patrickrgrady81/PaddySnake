class API::V1::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    username = params[:username]
    password = params[:password]
    user = User.find_by(username: username).try(:authenticate, password)
    if user 
      session[:user_id] = user.id
      render json: {user: user}
    else
      render json: {user: nil}
    end
  end
end
