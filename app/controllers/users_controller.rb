class UsersController < ApplicationController
  def index
    @dictionary = Score.dictionary
    @top_ten = Score.top_matches(current_user.id.to_s)
  end

  def show
    @user = User.find(params[:id])
  end
end
