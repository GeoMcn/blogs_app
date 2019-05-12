require "rails_helper"

RSpec.feature "Deleting a Review" do
    before do
        
        @region = Region.create!(name: "Dublin")
        @cuisine = Cuisine.create!(name: "Thai")
        @role = Role.create!(name: "restaurant owner")
        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role)
        login_as(@john)
        @restaurant1 = Restaurant.create(title: "The first article", description: "Lorem ipsum", user: @john, region: @region, cuisine: @cuisine)
        @review = Review.create!(rating: "5", comment: "its good", user: @john, restaurant: @restaurant1)
    end
    
    scenario "A user deletes a review" do
         visit "/restaurants"
        
         click_link @restaurant1.title
         click_link "Delete Review"
        
        
         expect(page).to have_content("Review was successfully destroyed.")
         expect(page.current_path).to eq(restaurant_path(@restaurant1)) 
    end
    

end