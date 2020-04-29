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
    return if !validated?()
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
      render json: {user: nil, sent: {username: params[:username], 
                                      email: params[:email], 
                                      password: params[:password], 
                                      password_confirmation: params[:password_confirmation]}}
    end
  end

  private 
  def validated?() 
    if User.find_by(username: params[:username]) 
      render json: {user: nil, error: "User name taken."}
      return false
    end
    if User.find_by(email: params[:email]) 
      render json: {user: nil, error: "Email has an account, please sign in."}
      return false
    end
    if params[:password] != params[:password_confirmation] 
      render json: {user: nil, error: "Passwords must match."}
      return false
    end
    if params[:password].length < 8 
      render json: {user: nil, error: "Password must be at least 8 characters."}
      return false
    end
    true
  end
end