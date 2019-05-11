require "rails_helper"

RSpec.feature "Listing Articles" do
    before do
        @role = Role.create!(name: "restaurant owner")
        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role)
        @article1 = Article.create(title: "The first article", body: "Lorem ipsum", user: @john)
        @article2 = Article.create(title: "The second article", body: "Lorem ipsum 2", user: @john)
    end
    
    scenario "With articles created and user not signed in" do
        visit "/"
        
        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(page).to have_content(@article2.title)
        expect(page).to have_content(@article2.body)
        
        expect(page).to have_link(@article1.title)
        expect(page).to have_link(@article2.title)
        expect(page).not_to have_link("New Article")
    end
    
    scenario "A user lists all articles when signed in" do
        login_as(@john)
        visit "/"
        
        
        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(page).to have_content(@article2.title)
        expect(page).to have_content(@article2.body)
        
        expect(page).to have_link(@article1.title)
        expect(page).to have_link(@article2.title)
        expect(page).to have_link("New Article")
    end
    
    scenario "A user has no articles" do
        Article.delete_all
        visit "/"
        
        expect(page).not_to have_content(@article1.title)
        expect(page).not_to have_content(@article1.body)
        expect(page).not_to have_content(@article2.title)
        expect(page).not_to have_content(@article2.body)
        
        expect(page).not_to have_link(@article1.title)
        expect(page).not_to have_link(@article2.title)
        
        within("h1#no-articles") do
            expect(page).to have_content("No articles created.")
        end
       
    end
    
end