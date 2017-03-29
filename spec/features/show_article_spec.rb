require 'rails_helper'

RSpec.feature "Show Article" do

  before do
    joe = User.create(email: "joe@example.com", password: "password")
    login_as(joe)
    @article = Article.create(title: "Title one", body: "Body of article one", user: joe)
  end

  scenario "a user can see a specific article" do
    visit "/"

    click_link(@article.title)

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end
