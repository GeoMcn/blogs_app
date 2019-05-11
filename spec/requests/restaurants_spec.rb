require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
    
    before do
        @role = Role.create!(name: "restaurant owner")
        @role2 = Role.create!(name: "customer")
        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role)
        @fred = User.create!(email: "fred@gmail.com", password: "fredspassword", role: @role2)
        @restaurant = Restaurant.create!(title: "The first restaurant", description: "Lorem ipsum", user: @john)
    end
    
    describe 'Get /restaurants/:id/edit' do
        context 'with non signed in user' do
            before { get "/restaurants/#{@restaurant.id}/edit"}
            it "redirects to sign in page" do
                expect(response.status).to eq 302
                flash_message = "You need to sign in or sign up before continuing."
                expect(flash[:alert]).to eq flash_message
            end
        end
        
        context 'with signed in user who is non owner' do
            before do
                login_as(@fred)
                get "/restaurants/#{@restaurant.id}/edit"
            end
            
            it "redirects to the home page" do
                expect(response.status).to eq 302
                flash_message = "You can only edit your own restaurant"
                expect(flash[:alert]).to eq flash_message
            end
        end
        
        context 'with signed in user who is owner' do
            before do
                login_as(@john)
                get "/restaurants/#{@restaurant.id}/edit"
            end
            
            it "successfully edits restaurant" do
                expect(response.status).to eq 200
            end
            
        end
   end
    
    
    describe 'Get /restaurants/new' do
        context 'with non restaurant owner' do
            before do
                login_as(@fred)
            end
            before { get "/restaurants/new"}
            it "redirects to restaurants index page" do
                expect(response.status).to eq 302
                flash_message = "You can only create a restaurant if you are an owner"
                expect(flash[:alert]).to eq flash_message
            end
        end
        
        
        
        context 'with signed in user who is owner' do
            before do
                login_as(@john)
                get "/restaurants/new"
            end
            
            it "successfully edits restaurant" do
                expect(response.status).to eq 200
            end
            
        end
   end
    
    
    
    describe 'Get /restaurants/:id' do
        context 'with existing restaurant' do
            before { get "/restaurants/#{@restaurant.id}"}
            
            it "handles existing restaurant" do
                expect(response.status).to eq 200
            end
        end
        
        context 'with non-existing restaurant' do
            before { get "/restaurants/xxxx"}
            
            it "handles non-existing restaurant" do
                expect(response.status).to eq 302
                flash_message = "The restaurant you are looking for cannot be found"
                expect(flash[:alert]).to eq flash_message
            end
        end
    end
end