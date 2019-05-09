require "rails_helper"

RSpec.feature "Showing an Article" do
    before do
        @john = User.create!(email: "john@gmail.com", password: "examplepassword")
        login_as(@john)
        @article1 = Article.create(title: "The first article", body: "Lorem ipsum", user: @john)
    end
    
    scenario "A user shows an article" do
        visit "/"
        
        click_link @article1.title
        
        
        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(page.current_path).to eq(article_path(@article1))
    end
end