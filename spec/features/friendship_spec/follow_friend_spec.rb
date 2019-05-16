require "rails_helper"

RSpec.feature "Following Friend" do
    before do
        @region = Region.create!(name: "Dublin")
        @cuisine = Cuisine.create!(name: "Thai")
        @role = Role.create!(name: "restaurant owner")
        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role)
        @fred = User.create!(email: "fred@gmail.com", password: "fredspassword", role: @role)
        @susie = User.create!(email: "susie@gmail.com", password: "susiespassword", role: @role)
        @rory = User.create!(email: "rory@gmail.com", password: "roryspassword", role: @role)
        @friendship = Friendship.create(user_id: @john.id, friend_id: @rory.id)
        @restaurant1 = Restaurant.create(title: "The first article", description: "Lorem ipsum", user: @john, region: @region, cuisine: @cuisine)
        @restaurant2 = Restaurant.create(title: "The second article", description: "Lorem ipsum 2", user: @fred, region: @region, cuisine: @cuisine)
    end
    
    
    
    scenario "If signed in" do
        login_as(@john)
        visit "/restaurants"
        
        expect(page).to have_content(@fred.email)
        expect(page).to have_link(id: @fred.id)
        expect(page).to have_content(@susie.email)
        expect(page).to have_link(id: @susie.id) 
        expect(page).to have_content(@rory.email)
        expect(page).not_to have_link(id: @rory.id) 
        expect(page).not_to have_link(id: @john.id)
      
        
        click_link(id: @fred.id)
        
        expect(page).to have_content("Friendship has been created.")
        expect(page.current_path).to eq("/restaurants")
        
        expect(page).not_to have_link(id: @fred.id)  
    end
    
    scenario "If not signed in" do
        visit "/restaurants"
        
        expect(page).to have_content(@fred.email)
        expect(page).not_to have_link(id: @fred.id)
        expect(page).to have_content(@susie.email)
        expect(page).not_to have_link(id: @susie.id) 
         
        
        expect(page).not_to have_link(id: @john)
      
    end
end
    
