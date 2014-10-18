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
      right = Hash.new(0)
      right[params["beer_id"].to_s] = review_params["taste"].to_i
      dict = Dictionary.find(Dictionary.last.id)
      dict.payload[current_user.id.to_s] = Hash.new
      dict.payload[current_user.id.to_s][params["beer_id"].to_s] = review_params["taste"].to_i
      dict.update_column(:payload, dict.payload)
      dict.save
      flash[:notice] = "Review created successfully"
      redirect_to beer_path(params[:beer_id])
    else
      flash[:notice] = "Review not created. Please try again."
      redirect_to beer_path(params[:beer_id])
    end
  end

  private

  def review_params
    params.require(:review).permit(:text, :taste)
  end
end
