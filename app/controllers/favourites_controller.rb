#class FavouritesController < ApplicationController
#    before_action :authenticate_user!
#    
#   def show
#   end
#    
#    def create
#        
#        savedFavourite = Restaurant.find(params[:restaurant_id])
#        @favourite = Favourite.new(favourites_params) unless current_user.follows_or_same?(savedFavourite)
#        @favourite.user_id = current_user.id
##        params[:user_id current_user.id]
#        if @favourite.save
##        Favourite.create
#            flash[:success] = "Restaurant has been favourited."
#            redirect_to restaurants_path
#        else
#            flash[:success] = "Restaurant has not been favourited."
#            redirect_to restaurants_path
#        end
#            
##        @favourite = Favourite.new(favourites_params)
##        @favourite.user_id = current_user.id
###        
###        @favourite.create!(favourites_params) unless current_user.follows_or_same?(savedFavourite)
##       
##         @favourite.save  unless current_user.follows_or_same?(@favourite)
##              flash[:success] = "Restaurant has been favourited."
##              redirect_to restaurants_path
#        
#    end
#    
#    def destroy
#        
#         if @favourite.destroy
#           flash[:success] = "Favourite has been removed."
#           redirect_to restaurants_path
#         end
#    end
#    
#    private
#    
#    def favourites_params
#        params.permit(:savedFavourite_id, :user_id)
#    end
#end
