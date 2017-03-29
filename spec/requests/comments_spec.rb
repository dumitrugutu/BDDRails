require 'rails_helper'

RSpec.describe "Comments", type: :request do

  before do
    @joe = User.create(email: "joe@example.com", password: "password")
    @lisa = User.create(email: "lisa@example.com", password: "password")
    @article = Article.create(title: "Title one", body: "Body of article one", user: @joe)
  end

  describe "POST /articles/:id/comments" do
    context "a non-signed in user" do
      before do
        post "/articles/#{@article.id}/comments", params: { comment: { body: "Awesome blog"}}
      end

      it "redirects user to the sign in page" do
        flash_message = "Please sign in or sign up first"
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq flash_message
      end
    end

    context "a signed in user" do
      before do
        login_as(@lisa)
        post "/articles/#{@article.id}/comments", params: { comment: { body: "Awesome blog"}}
      end

      it "creates a comment successfully" do
        flash_message = "Comment has been created"
        expect(response).to redirect_to(article_path(@article))
        expect(response.status).to eq 302
        expect(flash[:notice]).to eq flash_message
      end
    end
  end
end
