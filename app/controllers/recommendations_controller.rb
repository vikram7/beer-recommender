class RecommendationsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user_id = params[:user_id]
    @recommendations = Score.recommendations(@user_id)
  end

end
