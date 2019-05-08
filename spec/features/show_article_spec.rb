require "rails_helper"

RSpec.feature "Showing an Article" do
    before do
        @article1 = Article.create(title: "The first article", body: "Lorem ipsum")
    end
    
    scenario "A user shows an article" do
        visit "/"
        
        click_link @article1.title
        
        
        expect(page).to have_content(@article1.title)
        expect(page).to have_content(@article1.body)
        expect(page.current_path).to eq(article_path(@article1))
    end
end