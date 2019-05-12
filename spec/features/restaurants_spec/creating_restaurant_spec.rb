require "rails_helper"

RSpec.feature "Creating Restaurants" do
    before do
        @region = Region.create!(name: "Dublin")
        @cuisine = Cuisine.create!(name: "Thai")
        @role = Role.create!(name: "restaurant owner")
        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role) 
        login_as(@john)
    end
    scenario "A user creates a new restaurant" do
        visit "/restaurants"
        
        
        click_link "New Restaurant"
        
         choose('Dublin', allow_label_click: true)
         choose('Thai', allow_label_click: true)
        
        fill_in "Title", with: "Example" 
        fill_in "Description", with: "Lorem Ipsum"
        
        click_button "Create Restaurant"
        
        expect(Restaurant.last.user).to eq(@john)
        expect(page).to have_content("Restaurant has been created.")
        expect(page.current_path).to eq(restaurants_path)
        #expect(page).to have_content("Created by #{@john.email}")
    end
    
    scenario "A user fails to create a new restaurant" do
        visit "/restaurants"
        
        click_link "New Restaurant"
        
        fill_in "Title", with: "" 
        fill_in "Description", with: ""
        
        click_button "Create Restaurant"
        
        expect(page).to have_content("Restaurant has not been created")
        expect(page).to have_content("Title can't be blank")
        expect(page).to have_content("Description can't be blank")
    end
end