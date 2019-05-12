require "rails_helper"

RSpec.feature "Creating Reviews" do
    before do
        @region = Region.create!(name: "Dublin")
        @cuisine = Cuisine.create!(name: "Thai")
        @role = Role.create!(name: "restaurant owner")
        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role) 
        login_as(@john)
        @restaurant = Restaurant.create(title: "restaurant", description: "Lorem ipsum", user: @john, region: @region, cuisine: @cuisine)
    end
    scenario "A user writes a review" do
        visit "/restaurants"
        
        
        click_link @restaurant.title
        click_link 'write a review'
        
        fill_in "Rating", with: "5"
        fill_in "Comment", with: "Good Food"
        
        
        click_button "Create Review"
        
        expect(Review.last.user).to eq(@john)
        expect(Review.last.restaurant).to eq(@restaurant)
        expect(page.current_path).to eq(restaurant_path(@restaurant)) 
        expect(page).to have_content("The review was created!")
    end
    
    scenario "A user fails to write a review" do
        visit "/restaurants"
        
        
        click_link @restaurant.title
        click_link 'write a review'
        
        fill_in "Rating", with: ""
        fill_in "Comment", with: "comment"
        
        
        click_button "Create Review"
        
        expect(page).to have_content("The review was not created! Rating is needed.") 
    end
end