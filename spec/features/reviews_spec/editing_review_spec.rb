require "rails_helper"

RSpec.feature "Editing a Review" do
    before do
        @region = Region.create!(name: "Dublin")
        @cuisine = Cuisine.create!(name: "Thai")
        @role = Role.create!(name: "restaurant owner")
        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role)
        login_as(@john)
        @restaurant1 = Restaurant.create(title: "Updated Restaurant", description: "Lorem ipsum", user: @john, region: @region, cuisine: @cuisine)
        @review = Review.create!(rating: "5", comment: "its good", user: @john, restaurant: @restaurant1)
    end
    
    scenario "A user updates a review" do
         visit "/restaurants"
        
         click_link @restaurant1.title
         click_link "Edit Review"
        
         fill_in "Rating", with: "2" 
         fill_in "Comment", with: "Poor food"
        
         click_button "Update Review"
        
         expect(page).to have_content("Review was successfully updated.")
         expect(page.current_path).to eq(restaurant_path(@restaurant1))
    end
    
    scenario "A user fails to update a restaurant" do
         visit "/restaurants"
        
         click_link @restaurant1.title
         click_link "Edit Review"
        
         fill_in "Rating", with: "" 
         fill_in "Comment", with: ""
        
         click_button "Update Review"
        
         expect(page).to have_content("Review has not been updated.")
         expect(page.current_path).to eq(restaurant_path(@restaurant1))
    end
     
   
end