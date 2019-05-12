require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
    
    before do
        @region = Region.create!(name: "Dublin")
        @cuisine = Cuisine.create!(name: "Thai")
        @role = Role.create!(name: "restaurant owner")
        @role2 = Role.create!(name: "customer")
        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role)
        @fred = User.create!(email: "fred@gmail.com", password: "fredspassword", role: @role2)
        @restaurant = Restaurant.create!(title: "The first restaurant", description: "Lorem ipsum", user: @john, region: @region, cuisine: @cuisine)
    end
    
    describe 'Get /restaurants/:id/reviews/new' do
        context 'with non signed in user' do
             
            before { get "/restaurants/:id/reviews/new"}
            it "redirects to restaurants index page" do
                expect(response.status).to eq 320
                flash_message = "You can only write a review if you are a customer. Please sign up or sign in to continue"
                expect(flash[:alert]).to eq flash_message
            end
        end
   end  
end