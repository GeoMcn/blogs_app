require 'rails_helper'

RSpec.describe "Articles", type: :request do
    
    before do
        @role = Role.create!(name: "restaurant owner")
        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role)
        @fred = User.create!(email: "fred@gmail.com", password: "fredspassword", role: @role)
        @article = Article.create!(title: "The first article", body: "Lorem ipsum", user: @john)
    end
    
    describe 'Get /articles/:id/edit' do
        context 'with non signed in user' do
            before { get "/articles/#{@article.id}/edit"}
            it "redirects to sign in page" do
                expect(response.status).to eq 302
                flash_message = "You need to sign in or sign up before continuing."
                expect(flash[:alert]).to eq flash_message
            end
        end
        
        context 'with signed in user who is non owner' do
            before do
                login_as(@fred)
                get "/articles/#{@article.id}/edit"
            end
            
            it "redirects to the home page" do
                expect(response.status).to eq 302
                flash_message = "You can only edit your own article"
                expect(flash[:alert]).to eq flash_message
            end
        end
        
        context 'with signed in user who is owner' do
            before do
                login_as(@john)
                get "/articles/#{@article.id}/edit"
            end
            
            it "successfully edits article" do
                expect(response.status).to eq 200
            end
            
        end
   end
    
    
    
    describe 'Get /articles/:id' do
        context 'with existing article' do
            before { get "/articles/#{@article.id}"}
            
            it "handles existing article" do
                expect(response.status).to eq 200
            end
        end
        
        context 'with non-existing article' do
            before { get "/articles/xxxx"}
            
            it "handles non-existing article" do
                expect(response.status).to eq 302
                flash_message = "The article you are looking for cannot be found"
                expect(flash[:alert]).to eq flash_message
            end
        end
    end
end