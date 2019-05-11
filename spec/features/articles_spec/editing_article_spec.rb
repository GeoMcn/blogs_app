require "rails_helper"

RSpec.feature "Editing an Article" do
    before do
        @role = Role.create!(name: "restaurant owner")
        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role)
        login_as(@john)
        @article1 = Article.create(title: "The first article", body: "Lorem ipsum", user: @john)
    end
    
    scenario "A user updates an article" do
         visit "/"
        
         click_link @article1.title
         click_link "Edit Article"
        
         fill_in "Title", with: "Updated Blog" 
         fill_in "Body", with: "Update Lorem Ipsum"
        
         click_button "Update Article"
        
         expect(page).to have_content("Article has been updated.")
         expect(page.current_path).to eq(article_path(@article1))
    end
    
    scenario "A user fails to update an article" do
         visit "/"
        
         click_link @article1.title
         click_link "Edit Article"
        
         fill_in "Title", with: "" 
         fill_in "Body", with: "Update Lorem Ipsum"
        
         click_button "Update Article"
        
         expect(page).to have_content("Article has not been updated")
         expect(page.current_path).to eq(article_path(@article1))
    end
end