require "rails_helper"

RSpec.feature "Sign in users" do
    before do
        @role = Role.create!(name: "restaurant owner")
        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role)
    end
    
    scenario "With valid credentials" do
        visit "/"
        
        click_link "Sign in"
        
        fill_in "Email", with: "john@gmail.com" 
        fill_in "Password", with: "examplepassword"
        
        click_button "Log in"
        
        expect(page).to have_content("Signed in successfully")
        expect(page).to have_content("Signed in as #{@john.email}")
        expect(page).not_to have_link("Sign in")
        expect(page).not_to have_link("Sign up")
        
    end
    
    scenario "With invalid credentials" do
        visit "/"
        
        click_link "Sign in"
        
        fill_in "Email", with: "" 
        fill_in "Password", with: ""
        
        click_button "Log in"
        
        expect(page).to have_content("Invalid Email or password.")
        
    end
end