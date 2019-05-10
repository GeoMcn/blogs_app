require "rails_helper"

RSpec.feature "Editing a Restaurant" do
    before do
        @john = User.create!(email: "john@gmail.com", password: "examplepassword")
        login_as(@john)
        @restaurant1 = Restaurant.create(title: "Updated Restaurant", description: "Lorem ipsum", user: @john)
    end
    
    scenario "A user updates a restaurant" do
         visit "/restaurants"
        
         click_link @restaurant1.title
         click_link "Edit Restaurant"
        
         fill_in "Title", with: "Updated Restaurant" 
         fill_in "Description", with: "Update Lorem Ipsum"
        
         click_button "Update Restaurant"
        
         expect(page).to have_content("Restaurant has been updated.")
         expect(page.current_path).to eq(restaurant_path(@restaurant1))
    end
    
    scenario "A user fails to update a restaurant" do
         visit "/restaurants"
        
         click_link @restaurant1.title
         click_link "Edit Restaurant"
        
         fill_in "Title", with: "" 
         fill_in "Description", with: "Update Lorem Ipsum"
        
         click_button "Update Restaurant"
        
         expect(page).to have_content("Restaurant has not been updated")
         expect(page.current_path).to eq(restaurant_path(@restaurant1))
    end
end