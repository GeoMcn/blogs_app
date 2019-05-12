require "rails_helper"

RSpec.feature "Showing a Restaurant" do
    before do
        @region = Region.create!(name: "Dublin")
        @cuisine = Cuisine.create!(name: "Thai")
        @role = Role.create!(name: "restaurant owner")
        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role)
        @fred = User.create!(email: "fred@gmail.com", password: "fredspassword", role: @role)
        @restaurant = Restaurant.create(title: "restaurant", description: "Lorem ipsum", user: @john, region: @region, cuisine: @cuisine)
        @review = Review.create!(comment: "good food", rating: "5", restaurant: @restaurant, user: @john)
    end
    
    scenario "A signed in user shows their restaurant" do
        login_as(@john)
        visit "/restaurants"
        
        click_link @restaurant.title
        
        
        expect(page).to have_content(@restaurant.title)
        expect(page).to have_content(@restaurant.description)
        expect(page).to have_content(@restaurant.region.name)
        expect(page).to have_content(@restaurant.cuisine.name)
        expect(page).to have_content(@review.comment)
        expect(page).to have_content(@review.rating)
        expect(page.current_path).to eq(restaurant_path(@restaurant))
        
        expect(page).to have_link("Edit Restaurant")
        expect(page).to have_link("Delete Restaurant")
        expect(page).to have_link("write a review")
    end
    
    scenario "A siged in user shows another persons restaurant" do
        login_as(@fred)
        visit "/restaurants"
        
        click_link @restaurant.title
        
        
        expect(page).to have_content(@restaurant.title)
        expect(page).to have_content(@restaurant.description)
        expect(page).to have_content(@review.comment)
        expect(page).to have_content(@review.rating)
        expect(page.current_path).to eq(restaurant_path(@restaurant))
        expect(page).not_to have_link("Edit Restaurant")
        expect(page).not_to have_link("Delete Restaurant")
        expect(page).to have_link("write a review")
    end
    
    
    scenario "A user who is not signed in shows a restaurant" do
        
        visit "/restaurants"
        
        click_link @restaurant.title
        
        
        expect(page).to have_content(@restaurant.title)
        expect(page).to have_content(@restaurant.description)
        expect(page).to have_content(@review.comment)
        expect(page).to have_content(@review.rating)
        expect(page.current_path).to eq(restaurant_path(@restaurant))
        expect(page).not_to have_link("Edit Restaurant")
        expect(page).not_to have_link("Delete Restaurant")
        expect(page).not_to have_link("Edit Review")
        expect(page).not_to have_link("write a review")
    end
    
end