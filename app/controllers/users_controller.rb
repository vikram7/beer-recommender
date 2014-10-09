class UsersController < ApplicationController
  def index
    @dictionary = Score.dictionary
    @top_ten = Score.top_matches(current_user.id.to_s)
    @top_ten.each do |array|
      if array.include?(current_user.id.to_s)
        @top_ten.delete(array)
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
