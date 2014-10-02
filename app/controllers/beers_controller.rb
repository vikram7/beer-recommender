class BeersController < ApplicationController

  def index

    if params[:search] == nil
      @beers = Beer.order(name: :asc)
    else
      @beers = Beer.search(params[:search]).order(name: :asc)
    end

  end

  def show
    @beer = Beer.find(params[:id])
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

  # def root
  #   @restaurants = Restaurant.order(created_at: :desc).limit(10)
  # end

  # def new
  #   @restaurant = Restaurant.new
  # end

  # def create
  #   @restaurant = Restaurant.create(restaurant_params)

  #   if @restaurant.save
  #     flash[:notice] = "Added Restaurant"
  #     redirect_to restaurant_path(@restaurant)
  #   else
  #     flash[:notice] = "Please enter details again"
  #     render :new
  #   end
  # end


  private

  def beer_params
    # params.require(:restaurant).permit(:name, :address, :city, :state, :zip_code, :description, :category)
  end

end
