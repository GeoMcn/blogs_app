class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :articles, dependent: :destroy
  has_many :restaurants
  has_many :reviews, dependent: :destroy
  has_many :friendships
  has_many :friends, through: :friendships, class_name: "User"
  
    
  belongs_to :role
 
    def follows_or_same?(new_friend)
        friendships.map(&:friend).include?(new_friend) || self == new_friend
    end
     
    def current_friendship(friend)
        friendships.where(friend: friend).first
    end
    
end
