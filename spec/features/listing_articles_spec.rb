require 'rails_helper'

RSpec.feature "Listing Articles" do

  before do
    joe = User.create(email: "joe@example.com", password: "password")
    login_as(joe)
    @article1 = Article.create!(title: "The first article", body: "This is something I said", user: joe)
    @article2 = Article.create!(title: "This is the second article", body: "This more stuff I said", user: joe)
  end

  scenario "A user lists all articles" do
    visit '/'

    expect(page).to have_content(@article1.title)
    expect(page).to have_content(@article1.body)
    expect(page).to have_content(@article2.title)
    expect(page).to have_content(@article2.body)
    expect(page).to have_link(@article1.title)
    expect(page).to have_link(@article2.title)
  end

  scenario "A user has no articles" do
    Article.delete_all

    visit '/'

    expect(page).not_to have_content(@article1.title)
    expect(page).not_to have_content(@article1.body)
    expect(page).not_to have_content(@article2.title)
    expect(page).not_to have_content(@article2.body)
    expect(page).not_to have_link(@article1.title)
    expect(page).not_to have_link(@article2.title)

    within ("h1#no-articles") do
      expect(page).to have_content("There aren't any articles")
    end
  end

end
