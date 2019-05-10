require "rails_helper"

RSpec.feature "Creating Restaurants" do
    before do
        @john = User.create!(email: "john@gmail.com", password: "examplepassword")
        login_as(@john)
    end
    scenario "A user creates a new restaurant" do
        visit "/restaurants"
        
        
        click_link "New Restaurant"
        
        fill_in "Title", with: "Example" 
        fill_in "Description", with: "Lorem Ipsum"
        
        click_button "Create Restaurant"
        
        #expect(Article.last.user).to eq(@john)
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