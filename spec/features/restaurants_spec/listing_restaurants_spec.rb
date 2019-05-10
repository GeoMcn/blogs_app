require "rails_helper"

RSpec.feature "Listing Restaurants" do
    before do
        @john = User.create!(email: "john@gmail.com", password: "examplepassword")
        @restaurant1 = Restaurant.create(title: "The first article", description: "Lorem ipsum", user: @john)
        @restaurant2 = Restaurant.create(title: "The second article", description: "Lorem ipsum 2", user: @john)
    end
    
    scenario "With restaurants created and user not signed in" do
        visit "/restaurants"
        
        expect(page).to have_content(@restaurant1.title)
        expect(page).to have_content(@restaurant1.description)
        expect(page).to have_content(@restaurant2.title)
        expect(page).to have_content(@restaurant2.description)
        
        expect(page).to have_link(@restaurant1.title)
        expect(page).to have_link(@restaurant2.title)
        expect(page).not_to have_link("New Restaurant")
    end
    
    scenario "A user lists all restaurants when signed in" do
        login_as(@john)
        visit "/restaurants"
        
        
        expect(page).to have_content(@restaurant1.title)
        expect(page).to have_content(@restaurant1.description)
        expect(page).to have_content(@restaurant2.title)
        expect(page).to have_content(@restaurant2.description)
        
        expect(page).to have_link(@restaurant1.title)
        expect(page).to have_link(@restaurant2.title)
        expect(page).to have_link("New Restaurant")
    end
    
    scenario "A user has no restaurants" do
        Restaurant.delete_all
        visit "/restaurants"
        
        expect(page).not_to have_content(@restaurant1.title)
        expect(page).not_to have_content(@restaurant1.description)
        expect(page).not_to have_content(@restaurant2.title)
        expect(page).not_to have_content(@restaurant2.description)
        
        expect(page).not_to have_link(@restaurant1.title)
        expect(page).not_to have_link(@restaurant2.title)
        
        within("h1#no-articles") do
            expect(page).to have_content("No restaurants created.")
        end
       
    end
    
end