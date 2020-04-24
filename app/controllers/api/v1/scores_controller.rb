if Rails.env.development?
  require 'pry'
end

class API::V1::ScoresController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    scores = getHighScores
    names = scores.collect do |s|
      User.find(s.user_id).username
    end
    info = names.map.with_index(0) do |name, i|
      {name: name, score: scores[i].value}
    end
    render json: info
  end

  def show
    score = Score.find_by(id: params[:id])
    if score
      render json: score.slice(:id, :user_id, :value), include: [email: score.user.email]
    else 
      render json: {error: "Score not found"}
    end
  end

  def create 
    user = User.find_by(username: params[:user])
    if user
      Score.create(user_id: user.id, value: params[:score]) 
    end

    # send back new high score list
     scores = getHighScores
     render json: scores
  end

  private

  def getHighScores 
    scores = Score.all.order("value DESC").limit(10)
    if scores.count < 10
      (10-scores.count).times{
        Score.create(user_id: User.first.id, value: 0)
      }
      scores = Score.all.order("value DESC").limit(10)
    end
    return scores
  end
end
