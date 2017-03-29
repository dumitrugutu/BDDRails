require "rails_helper"

RSpec.feature "Creating Articles" do

  before do
    @joe = User.create(email: "joe@example.com", password: "password")

    # buit in method provided by Warden::Test::Helpers. See rails_helper
    login_as(@joe)
  end

  scenario "A user creates a new article" do
    visit "/"

    click_link "New Article"

    fill_in "Title", with: "Creating a blog"
    fill_in "Body", with: "I've got something to say!"

    click_button "Create Article"

    expect(Article.last.user).to eq(@joe)
    expect(page).to have_content("Article has been created")
    expect(page.current_path).to eq(articles_path)
    expect(page).to have_content("Created by: #{@joe.email}")
  end
end
