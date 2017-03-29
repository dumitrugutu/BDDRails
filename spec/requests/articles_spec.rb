require 'rails_helper'

RSpec.describe "Articles", type: :request do

  before do
    @joe = User.create(email: "joe@example.com", password: "password")
    @lisa = User.create(email: "lisa@example.com", password: "password")
    @article = Article.create(title: "Title one", body: "Body of article one", user: @joe)
  end

  describe "GET /articles/:id/edit" do
    context "with non-signed in user" do
      before { get "/articles/#{@article.id}/edit" }

      it "redirects to the signin page" do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context "with signed in user who is non-author" do
      before do
        login_as(@lisa)
        get "/articles/#{@article.id}/edit"
      end

      it "redirects to the home page" do
        expect(response.status).to eq 302
        flash_message = "You can only edit your own artciles."
        expect(flash[:alert]).to eq flash_message
      end
    end
  end

  describe "GET /articles/:id" do
    context "with existing article" do
      before { get "/articles/#{@article.id}" }

      it "handles existing articles" do
        expect(response.status).to eq 200
      end
    end

    context "with non-existing article" do
      before { get "/articles/xxxx" }

      it "handles non-existing article" do
        expect(response.status).to eq 302
        flash_message = "The article could not be found"
        expect(flash[:alert]).to eq flash_message
      end
    end

    context "with signed in user and author" do
      before do
        login_as(@joe)
        get "/articles/#{@article.id}/edit"
      end

      it "successfully edits article" do
        expect(response.status).to eq 200
      end
    end
  end
end
