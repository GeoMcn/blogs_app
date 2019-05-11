require "rails_helper"

RSpec.feature "Signup users" do
    before do
        @role = Role.create!(name: "customer")
    end
        
    scenario "With valid credentials" do
        visit "/"
        
        click_link "Sign up"
        
        choose('customer', allow_label_click: true)
        
        fill_in "Email", with: "geogeo@gmail.com" 
        fill_in "Password", with: "Geogeo12345"
        fill_in "Password confirmation", with: "Geogeo12345"
        
        click_button "Create User"
        
        expect(page).to have_content("You have signed up successfully")
        expect(page.current_path).to eq("/")
        
    end
    
    scenario "With invalid credentials" do
        visit "/"
        
        click_link "Sign up"
        
        choose('customer', allow_label_click: true)
        
        fill_in "Email", with: "" 
        fill_in "Password", with: ""
        fill_in "Password confirmation", with: ""
        
        click_button "Create User"
        
        #expect(page).to have_content("You have not signed up successfully")
    end
    
end