require 'rails_helper'

RSpec.feature "Delete an article" do

  before do
    joe = User.create(email: "joe@example.com", password: "password")
    login_as(joe)
    @article = Article.create(title: "Title one", body: "Body of article one", user: joe)
  end

  scenario "A user deletes an article" do
    visit "/"

    click_link @article.title
    click_link "Delete Article"

    expect(page).to have_content("Article has been deleted")
    expect(current_path).to eq(articles_path)
  end
end
