class ReviewsController < ApplicationController
     before_action :authenticate_user!, except: [:index, :show]
     before_action :set_review, only: [:show, :edit, :update, :destroy]
     before_action :set_restaurant 

   
  
  def new
     @review = Review.new
  end

  
  def edit
      unless @review.user == current_user 
          flash[:danger] = "You can only edit your own reviews"
          redirect_to restaurants_path
      end 
  end


  def create
         @review = Review.new(review_params)
        @review.user_id = current_user.id
        @review.restaurant_id = @restaurant.id
        if @review.save
            redirect_to @restaurant, notice: 'The review was created!'
        else 
            redirect_to @restaurant, notice: 'The review was not created! Rating is needed.'
        end 
      
  end

  def update
       unless @review.user == current_user
          flash[:danger] = "You can only delete your own restaurant"
          redirect_to restaurants_path
       else
            respond_to do |format|
              if @review.update(review_params)
                format.html { redirect_to @restaurant, notice: 'Review was successfully updated.' }
              else
                format.html { redirect_to @restaurant, notice: 'Review has not been updated.' }
              end
            end
       end
  end

  def destroy
      @restaurant = Restaurant.find(params[:id] = @review.restaurant_id )
    @review.destroy
      redirect_to @restaurant, notice: 'Review was successfully destroyed.'
    
  end

  private
    
    def set_review
      @review = Review.find(params[:id])
    end
    
    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

   
    def review_params
      params.require(:review).permit(:user_id, :rating, :comment)
    end
    
    
end
