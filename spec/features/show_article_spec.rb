require 'rails_helper'

RSpec.feature "Show Article" do

  before do
    @joe = User.create(email: "joe@example.com", password: "password")
    @lisa = User.create(email: "lisa@emaple.com", password: "password")
    @article = Article.create(title: "Title one", body: "Body of article one", user: @joe)
  end

  scenario "hide Edit and Delete buttons to non-signed in users" do
    visit "/"

    click_link(@article.title)

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end

  scenario "hide Edit and Delete buttons to non-authors" do
    login_as(@lisa)
    visit "/"

    click_link(@article.title)

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
    expect(page).not_to have_link("Edit Article")
    expect(page).not_to have_link("Delete Article")
  end
end
