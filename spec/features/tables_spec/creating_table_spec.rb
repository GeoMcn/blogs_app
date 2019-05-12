#RSpec.feature "Creating Tables" do
#    before do
#        @region = Region.create!(name: "Dublin")
#        @cuisine = Cuisine.create!(name: "Thai")
#        @role = Role.create!(name: "restaurant owner")
#        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role) 
#        login_as(@john)
#        @restaurant = Restaurant.create(title: "restaurant", description: "Lorem ipsum", user: @john, region: @region, cuisine: @cuisine)
#    end
#    scenario "A restaurant owner creates a new table" do
#        visit "/restaurants"
#        
#        
#        click_link @restaurant.title
#        click_link "Add New table"
#        
#         choose('restaurant', allow_label_click: true)
#        
#        fill_in "Seats", with: "5" 
#        
#        click_button "Create Table"
#        
#        expect(Restaurant.last.user).to eq(@john)
#        expect(page).to have_content("Restaurant has been created.")
#        expect(page.current_path).to eq(restaurants_path)
#        #expect(page).to have_content("Created by #{@john.email}")
#    end
#    
#    scenario "A user fails to create a new restaurant" do
#        visit "/restaurants"
#        
#        click_link "New Restaurant"
#        
#        fill_in "Title", with: "" 
#        fill_in "Description", with: ""
#        
#        click_button "Create Restaurant"
#        
#        expect(page).to have_content("Restaurant has not been created")
#        expect(page).to have_content("Title can't be blank")
#        expect(page).to have_content("Description can't be blank")
#    end
#end