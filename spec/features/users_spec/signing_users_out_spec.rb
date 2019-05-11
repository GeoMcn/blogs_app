require "rails_helper"

RSpec.feature "Signing out signed in users" do
    before do
        @role = Role.create!(name: "restaurant owner")
        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role)
        
        visit "/"
        
        click_link "Sign in"
        
        fill_in "Email", with: "john@gmail.com" 
        fill_in "Password", with: "examplepassword"
        
        click_button "Log in"
    end
    
    scenario "sign out successfully" do
        visit "/"
        
        click_link "Sign out"
        
        expect(page).to have_content("Signed out successfully")
        expect(page).not_to have_link("Sign out")
        expect(page).to have_link("Sign in")
        expect(page).to have_link("Sign up")
        
    end
    
end