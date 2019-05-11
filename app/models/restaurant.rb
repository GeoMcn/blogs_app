class Restaurant < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    
    belongs_to :user
    belongs_to :region
    
    default_scope {order(created_at: :desc)}
end
