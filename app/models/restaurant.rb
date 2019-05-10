class Restaurant < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    
    default_scope {order(created_at: :desc)}
end
