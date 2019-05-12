require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
    
    before do
        @region = Region.create!(name: "Dublin")
        @cuisine = Cuisine.create!(name: "Thai")
        @role = Role.create!(name: "restaurant owner")
        @role2 = Role.create!(name: "customer")
        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role)
        
        @restaurant = Restaurant.create!(title: "The first restaurant", description: "Lorem ipsum", user: @john, region: @region, cuisine: @cuisine)
        @review = Review.create!(rating: "4", comment: "very nice", user: @john, restaurant: @restaurant)
        @fred = User.create!(email: "fred@gmail.com", password: "fredspassword", role: @role2)
    end
    
#    Testing new controller method requests
    
    describe 'Get /restaurants/:restaurant_id/reviews/new' do 
        context 'with non signed in user' do  
             
            before { get "/restaurants/:id/reviews/new"}
            it "redirects to restaurants index page" do
                expect(response.status).to eq 302 
                flash_message = "You need to sign in or sign up before continuing."
                expect(flash[:alert]).to eq flash_message
            end
        end
        
        context 'with signed in user' do
            before do
                login_as(@john)
                get "/restaurants/#{@restaurant.id}/reviews/new"
            end
            
            it "successfully edits restaurant" do
                expect(response.status).to eq 200
            end
        end
    end  
    
    
    
#    Testing edit controller method requests
    
    describe 'Get /restaurants/:restaurant_id/reviews/:id/edit' do 
        context 'with non signed in user' do  
             
            before { get "/restaurants/:id/reviews/:id/edit"}
                it "redirects to restaurants index page" do
                    expect(response.status).to eq 302 
                    flash_message = "You need to sign in or sign up before continuing."
                    expect(flash[:alert]).to eq flash_message
                end
        end
        
        context 'with signed in user & author' do
            before do
                login_as(@john)
                get "/restaurants/#{@restaurant.id}/reviews/:id/edit"
            end
            
            it "successfully edits restaurant" do
                expect(response.status).to eq 200
            end
        end
        
        context 'with signed in user who is non owner' do
            before do
                login_as(@fred)
                 get "/restaurants/#{@restaurant.id}/reviews/#{@review.id}/edit"
            end
            
            it "redirects to the restaurants page" do
                expect(response.status).to eq 302
                flash_message = "You can only edit your own reviews"
                expect(flash[:danger]).to eq flash_message
            end
         end
    end  
end