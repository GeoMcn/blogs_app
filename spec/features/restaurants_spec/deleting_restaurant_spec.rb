require "rails_helper"

RSpec.feature "Deleting a Restaurant" do
    before do
        @john = User.create!(email: "john@gmail.com", password: "examplepassword")
        login_as(@john)
        @restaurant1 = Restaurant.create(title: "The first article", description: "Lorem ipsum", user: @john)
    end
    
    scenario "A user deletes a restaurant" do
         visit "/restaurants"
        
         click_link @restaurant1.title
         click_link "Delete Restaurant"
        
        
         expect(page).to have_content("Restaurant has been deleted.")
         expect(page.current_path).to eq(restaurants_path)
    end
    

end