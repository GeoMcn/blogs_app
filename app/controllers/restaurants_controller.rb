class RestaurantsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  def index
      @restaurants = Restaurant.all
  end
  def new
      if current_user.role.name == "restaurant owner"
        @restaurant = Restaurant.new
      else 
          flash[:alert] = "You can only create a restaurant if you are an owner"
          redirect_to restaurants_path
      end
  end
    
  def create
      if current_user.role.name == "restaurant owner"
          @restaurant = Restaurant.new(restaurant_params)
          @restaurant.user = current_user
          if @restaurant.save
              flash[:success] = "Restaurant has been created."
              redirect_to restaurants_path
          else
              flash.now[:danger] = "Restaurant has not been created."
              render :new
          end
      end
      
      
  end
    
  def show
  end
    
  def edit
      unless @restaurant.user == current_user
          flash[:alert] = "You can only edit your own restaurant"
          redirect_to restaurants_path
      end
  end
    
  def update
      unless @restaurant.user == current_user
          flash[:danger] = "You can only edit your own restaurant"
          redirect_to restaurants_path
      else
          if @restaurant.update(restaurant_params)
              flash[:success] = "Restaurant has been updated."
              redirect_to @restaurant
          else
              flash.now[:danger] = "Restaurant has not been updated."
              render :new
          end
      end
  end
    
  def destroy
       unless @restaurant.user == current_user
          flash[:danger] = "You can only delete your own restaurant"
          redirect_to restaurants_path
      else
          if @restaurant.destroy
           flash[:success] = "Restaurant has been deleted."
           redirect_to restaurants_path
          end
       end
  end
    
    
  protected
    
    def resource_not_found
        message = "The restaurant you are looking for cannot be found"
        flash[:alert] = message
        redirect_to restaurants_path
    end
    
    private 
    
    def restaurant_params
        params.require(:restaurant).permit(:title, :description, :user)
    end
    def set_restaurant
        @restaurant = Restaurant.find(params[:id])
    end
    
end
