class BeersController < ApplicationController

  def index
    if params[:search] == nil
      @beers = Beer.order(name: :asc).page params[:page]
    else
      @beers = Beer.search(params[:search]).order(name: :asc).page params[:page]
    end
  end

  def show
    @review = Review.new
    @beer = Beer.find(params[:id])
    @reviews = @beer.reviews
    @average = 0
    @beer.reviews.each do |review|
      @average += review.taste
    end
    if @beer.reviews.count == 0
      @average = '--'
    else
      @average = (@average / @beer.reviews.count).round(1).to_s + '/10'
    end
  end

  private

  def beer_params
    # params.require(:restaurant).permit(:name, :address, :city, :state, :zip_code, :description, :category)
  end

end
