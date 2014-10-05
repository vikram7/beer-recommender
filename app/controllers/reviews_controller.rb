class ReviewsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.beer_id = params[:beer_id]
    @review.user_id = current_user.id
    if @review.save
      flash[:notice] = "Review created successfully"
      redirect_to beer_path(params[:beer_id])
    else
      flash[:notice] = "Review not created. Please try again."
      redirect_to beer_path(params[:beer_id])
    end
  end

  # def edit
  #   @review = Review.find(params[:id])
  #   @show = Show.find(@review.show_id)
  # end

  # def update
  #   @review = Review.find(params[:id])
  #   if @review.update(review_params)
  #     flash[:notice]= "Review updated successfully"
  #     redirect_to show_path(params[:show_id])
  #   end
  # end

  # def create
  #   @review = Review.new(review_params)
  #   @review.show_id = params[:show_id]
  #   @review.user_id = current_user.id
  #   if @review.save
  #     flash[:notice]= "Review created successfully"
  #     redirect_to show_path(params[:show_id])
  #   else
  #     flash[:notice]= "You didn't enter enough information."
  #     redirect_to show_path(params[:show_id])
  #   end
  # end

  # def show
  #   @review_id = params[:id]
  #   @review = Review.destroy(@review_id)
  #   if @review.save
  #     flash[:notice] = "Review deleted successfully"
  #     redirect_to show_path(params[:show_id])
  #   end
  # end

  # private

  def review_params
    params.require(:review).permit(:text, :taste)
  end
end
