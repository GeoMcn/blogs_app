class RestaurantsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  def index
      @restaurants = Restaurant.all
  end
  def new
      @restaurant = Restaurant.new
  end
    
  def create
      @restaurant = Restaurant.new(restaurant_params)
#      @restaurant.user = current_user
      if @restaurant.save
          flash[:success] = "Restaurant has been created."
          redirect_to restaurants_path
      else
          flash.now[:danger] = "Restaurant has not been created."
          render :new
      end
  end
    
    private 
    
    def restaurant_params
        params.require(:restaurant).permit(:title, :description)
    end
    def set_restaurant
        @restaurant = Restaurant.find(params[:id])
    end
end
