require "rails_helper"

RSpec.feature "Deleting a Restaurant" do
    before do
        
        @region = Region.create!(name: "Dublin")
        @cuisine = Cuisine.create!(name: "Thai")
        @role = Role.create!(name: "restaurant owner")
        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role)
        login_as(@john)
        @restaurant1 = Restaurant.create(title: "The first article", description: "Lorem ipsum", user: @john, region: @region, cuisine: @cuisine)
    end
    
    scenario "A user deletes a restaurant" do
         visit "/restaurants"
        
         click_link @restaurant1.title
         click_link "Delete Restaurant"
        
        
         expect(page).to have_content("Restaurant has been deleted.")
         expect(page.current_path).to eq(restaurants_path)
    end
    

end