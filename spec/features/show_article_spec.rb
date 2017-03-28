require 'rails_helper'

RSpec.feature "Show Article" do

  before do
    @article = Article.create!(title: "The first article", body: "This is something I said")
  end

  scenario "a user can see a specific article" do
    visit "/"

    click_link(@article.title)

    expect(page).to have_content(@article.title)
    expect(page).to have_content(@article.body)
    expect(current_path).to eq(article_path(@article))
  end
end
