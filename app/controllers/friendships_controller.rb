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
          @friendship = Friendship.create(friendship_params)
          @friendship.user_id = current_user.id
          if @friendship.save
              flash[:success] = "Friendship has been created."
              redirect_to articles_path
          else
              flash.now[:danger] = "Friendship has not been created."
              redirect_to articles_path
          end
      
    end
    
    def destroy
    end
    
   
    private
    
    def friendship_params
        params.permit( :user_id, :friend_id)
    end


    
end