require 'spec_helper'

describe "Posts" do
  describe "GET /posts" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get posts_path
      response.status.should be(200)
    end
  end


  describe "creating a post", :js => true do

    it "creates a Post and redirects to the Post's page" do
      get "/posts/new"
      response.should render_template(:new)

      post "/posts", :post => {title: "Test Post", body: "Interesting Stuff"}

      response.should redirect_to(assigns(:post))
      follow_redirect!

      response.should render_template(:post)
      response.body.should include("Post was successfully created.")
    end

  end


end
