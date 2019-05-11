require "rails_helper"

RSpec.feature "Deleting an Article" do
    before do
        @role = Role.create!(name: "restaurant owner")
        @john = User.create!(email: "john@gmail.com", password: "examplepassword", role: @role)
        
        login_as(@john)
        @article1 = Article.create(title: "The first article", body: "Lorem ipsum", user: @john)
    end
    
    scenario "A user deletes an article" do
         visit "/"
        
         click_link @article1.title
         click_link "Delete Article"
        
        
         expect(page).to have_content("Article has been deleted.")
         expect(page.current_path).to eq(articles_path)
    end
    

end