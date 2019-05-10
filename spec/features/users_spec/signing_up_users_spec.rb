require "rails_helper"

RSpec.feature "Signup users" do
        
    scenario "With valid credentials" do
        visit "/"
        
        click_link "Sign up"
        
        fill_in "Email", with: "geogeo@gmail.com" 
        fill_in "Password", with: "Geogeo12345"
        fill_in "Password confirmation", with: "Geogeo12345"
        click_button "Sign up"
        
        expect(page).to have_content("You have signed up successfully")
        expect(page.current_path).to eq("/")
        
    end
    
    scenario "With invalid credentials" do
        visit "/"
        
        click_link "Sign up"
        
        fill_in "Email", with: "" 
        fill_in "Password", with: ""
        fill_in "Password confirmation", with: ""
        
        click_button "Sign up"
        
        #expect(page).to have_content("You have not signed up successfully")
    end
    
end