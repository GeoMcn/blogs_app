class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_restaurant

  
  def new
    @review = Review.new
  end

  
  def edit
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
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
      @restaurant = Restaurant.find(params[:id] = @review.restaurant_id )
    @review.destroy
    respond_to do |format|
      format.html { redirect_to restaurant_path(@restaurant), notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
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
