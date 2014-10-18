class UsersController < ApplicationController
  def index
    @dictionary = Score.dictionary
    @top_twenty = Score.top_matches(current_user.id)
    @top_twenty.each do |array|
      if array.include?(current_user.id.to_s)
        @top_twenty.delete(array)
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

end
