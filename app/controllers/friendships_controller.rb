class FriendshipsController < ApplicationController
    before_action :authenticate_user!
    
    def index
         @user = current_user
         @email = @user.email
         @friendships = @user.friendships
    end
    
    def show
    end
    
    def create
          friend = User.find(params[:user_id])
          params[:user_id] = current_user.id
          @friendship = Friendship.create(friendship_params)
#          @friendship.user_id = current_user.id
          if @friendship.save
              flash[:success] = "Friendship has been created."
              redirect_to restaurants_path
          else
              flash.now[:danger] = "Friendship has not been created."
              redirect_to restaurants_path
          end
    end
    
    def destroy
        @friend = Friendship.find(params[:id])
        if @friend.destroy
             redirect_to friendships_path
        end
    end
        
    
   
    private
    
    def friendship_params
        params.permit( :user_id, :friend_id)
    end
    def set_friendship
        @friend = Frienship.find(params[:id])
    end
   


    
end