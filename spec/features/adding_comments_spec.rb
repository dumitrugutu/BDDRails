require 'rails_helper'

RSpec.feature "Adding comments to Articles" do

  before do
    @joe = User.create(email: "joe@example.com", password: "password")
    @lisa = User.create(email: "lisa@emaple.com", password: "password")
    @article = Article.create(title: "Title one", body: "Body of article one", user: @joe)
  end

  scenario "permits a signed in user to leave a comment" do
    login_as(@joe)

    visit "/"

    click_link @article.title
    fill_in "New Comment", with: "This is a great article!"
    click_button "Save Comment"

    expect(page).to have_content("Comment has been created")
    expect(page).to have_content("This is a great article!")
    expect(current_path).to eq(article_path(@article.id))
  end
end
