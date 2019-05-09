require "rails_helper"

RSpec.feature "Showing an Article" do
    before do
        @john = User.create!(email: "john@gmail.com", password: "examplepassword")
        @fred = User.create!(email: "fred@gmail.com", password: "fredspassword")
        @article1 = Article.create(title: "The first article", body: "Lorem ipsum", user: @john)
    end
    
    scenario "A signed in user shows their article" do
        login_as(@john)
        visit "/"
        
        click_link @article1.title
        
        
        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(page.current_path).to eq(article_path(@article1))
        
        expect(page).to have_link("Edit Article")
        expect(page).to have_link("Delete Article")
    end
    
    scenario "A user shows another persons article" do
        login_as(@fred)
        visit "/"
        
        click_link @article1.title
        
        
        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(page.current_path).to eq(article_path(@article1))
        expect(page).not_to have_link("Edit Article")
        expect(page).not_to have_link("Delete Article")
    end
    
    scenario "A user who is not signed in shows article" do
        visit "/"
        
        click_link @article1.title
        
        
        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(page.current_path).to eq(article_path(@article1))
        expect(page).not_to have_link("Edit Article")
        expect(page).not_to have_link("Delete Article")
    end
end