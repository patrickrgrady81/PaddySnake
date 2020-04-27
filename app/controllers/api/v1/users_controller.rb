if Rails.env.development?
  require 'pry'
end

class API::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index 
    users = User.all
    render json: users, only: [:username]
  end

  def create 
    user = User.new(
      username: params[:username],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    user_saved = user.save
    if user_saved
      session[:user_id] = user.id
      render json: {user: user}
    else
      render json: {user: nil, sent: {username: params[:username], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation]}}
    end
  end
end