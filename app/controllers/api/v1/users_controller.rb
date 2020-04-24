if Rails.env.development?
  require 'pry'
end

class API::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index 
    users = User.all
    render json: users, only: [:username]
  end

  def login
    username = params[:username]
    password = params[:password]
  end
end