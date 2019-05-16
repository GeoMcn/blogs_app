#require "rails_helper"
#
#RSpec.feature "Following Friend" do
#    before do
#        @region = Region.create!(name: "Dublin")
#        @cuisine = Cuisine.create!(name: "Thai")
#        @role = Role.create!(name: "restaurant owner")
#        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role)
#        login_as(@john)
#        @fred = User.create!(email: "fred@gmail.com", password: "fredspassword", role: @role)
#        @susie = User.create!(email: "susie@gmail.com", password: "susiespassword", role: @role)
#        @restaurant1 = Restaurant.create(title: "The first article", description: "Lorem ipsum", user: @john, region: @region, cuisine: @cuisine)
#        @restaurant2 = Restaurant.create(title: "The second article", description: "Lorem ipsum 2", user: @fred, region: @region, cuisine: @cuisine)
#        @friendship = Friendship.create(user: @john, friend: @fred)
#    end
#    
#    
#    
#    scenario "Through restaurants" do
#        visit "/restaurants"
#        
#        
#        expect(page).to have_content(@restaurant1.title)
#        expect(page).to have_content(@restaurant1.description)
#        expect(page).to have_content(@restaurant1.cuisine.name)
#        expect(page).to have_content(@restaurant2.title)
#        expect(page).to have_content(@restaurant2.description)
#        expect(page).to have_content(@restaurant2.cuisine.name)
#        
#        expect(page).to have_link(@restaurant1.title)
#        expect(page).to have_link(@restaurant2.title)
#        expect(page).to have_link("New Restaurant")
#        
#         expect(page).to have_link(@restaurant1.title)
#        expect(page).to have_link(@restaurant2.title)
#        
#        expect(page).to have_content(@fred.email)
#        expect(page).not_to have_link("Follow")
#        
#        href = "/friendshps?user_id=#{@fred.id}"
#        expect(page).to have_link("Unfollow")
#        
#        link = "a[href '/friendshps?user_id=#{@fred.id}']"
#        click_link "Unfollow"
#        
#        expect(page).to have_content("Unfollowed friend")
#        expect(page.current_path).to eq("/restaurants")
#        
#        href = "/friendshps?user_id=#{@fred.id}"
#        expect(page).to have_link("Follow", :href => href)
#    end
#    
#    scenario "Through Friendhips" do
#        
#        visit "/friendships"
#        
#     
#        expect(page).to have_content(@fred.email)
#        expect(page).not_to have_link("Follow")
#        href = "/friendshps?user_id=#{@fred.id}"
#        expect(page).to have_link("Unfollow", href => href)
#        
#        click_link "Unfollow"
#        
#        expect(page).to have_content("Unfollowed friend")
#        expect(page.current_path).to eq("/friendships")
#        
#        href = "/friendshps?user_id=#{@fred.id}"
#        expect(page).not_to have_link("Follow", :href => href)
#    end
#end
#    
##    scenario "There are no restaurants" do
##        Restaurant.delete_all
##        visit "/restaurants"
##        
##        expect(page).not_to have_content(@restaurant1.title)
##        expect(page).not_to have_content(@restaurant1.description)
##        expect(page).not_to have_content(@restaurant1.cuisine.name)
##        expect(page).not_to have_content(@restaurant2.title)
##        expect(page).not_to have_content(@restaurant2.description)
##        expect(page).not_to have_content(@restaurant2.cuisine.name)
##        
##        expect(page).not_to have_link(@restaurant1.title)
##        expect(page).not_to have_link(@restaurant2.title)
##        
##        
##        href = "/favorites?restaurant_id=#{@restaurant2.id}"
##        expect(page).not_to have_button("Follow")
##        
##        within("h1#no-articles") do
##            expect(page).to have_content("No restaurants created.")
##        end
##       
##    end
##end