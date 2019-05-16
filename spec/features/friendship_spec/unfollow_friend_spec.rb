require "rails_helper"

RSpec.feature "Unfollowing Friend" do
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

    scenario "Through Friendships" do
        login_as(@john)
        visit "/friendships"
        
        expect(page).not_to have_content(@fred.email)
        expect(page).not_to have_link("Unfollow", id: @fred.email)
        expect(page).not_to have_content(@susie.email)
        expect(page).not_to have_link("Unfollow", id: @susie.email)
        expect(page).to have_content(@rory.email)
        expect(page).to have_link("Unfollow", id: @rory.email)
      
#        Alternative way of unfollowing
#       click_link("Unfollow", id: @rory.email)
        
        link = "a[href='/friendships/#{@friendship.id}'][data-method='delete']"
        find(link).click

        expect(page.current_path).to eq("/friendships")
        expect(page).not_to have_content(@rory.email)
        expect(page).not_to have_link("Unfollow",id: @rory.id)  
    end
end