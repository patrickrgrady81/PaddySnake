class PagesController < ApplicationController
  def home
    render json: { status: "Up" }
  end
end