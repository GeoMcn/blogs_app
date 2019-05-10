require "rails_helper"

RSpec.feature "Showing a Restaurant" do
    before do
        @john = User.create!(email: "john@gmail.com", password: "examplepassword")
        @fred = User.create!(email: "fred@gmail.com", password: "fredspassword")
        @restaurant = Restaurant.create(title: "restaurant", description: "Lorem ipsum", user: @john)
    end
    
    scenario "A signed in user shows their restaurant" do
        login_as(@john)
        visit "/restaurants"
        
        click_link @restaurant.title
        
        
        expect(page).to have_content(@restaurant.title)
        expect(page).to have_content(@restaurant.description)
        expect(page.current_path).to eq(restaurant_path(@restaurant))
        
        expect(page).to have_link("Edit Restaurant")
        expect(page).to have_link("Delete Restaurant")
    end
    
    scenario "A siged in user shows another persons restaurant" do
        login_as(@fred)
        visit "/restaurants"
        
        click_link @restaurant.title
        
        
        expect(page).to have_content(@restaurant.title)
        expect(page).to have_content(@restaurant.description)
        expect(page.current_path).to eq(restaurant_path(@restaurant))
        expect(page).not_to have_link("Edit Restaurant")
        expect(page).not_to have_link("Delete Restaurant")
    end
    
    
    scenario "A user who is not signed in shows a restaurant" do
        
        visit "/restaurants"
        
        click_link @restaurant.title
        
        
        expect(page).to have_content(@restaurant.title)
        expect(page).to have_content(@restaurant.description)
        expect(page.current_path).to eq(restaurant_path(@restaurant))
        expect(page).not_to have_link("Edit Restaurant")
        expect(page).not_to have_link("Delete Restaurant")
    end
    
end