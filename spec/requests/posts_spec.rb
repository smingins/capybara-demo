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

    it "creates a Post and redirects to the Post's page (capybara DSL)" do
      visit('/posts/new')
      fill_in('Title', with: 'Test Post')
      click_button('Create Post')
      page.should have_content("Post was successfully created")
    end

    it "fails to create a Post without entering a title" do
      visit('/posts/new')
      click_button('Create Post')
      page.should have_content("Title can't be blank")
    end

    it "tickles when clicked and then resets" do
      visit('/posts/new')

      # initial links
      page.has_link?("Click Me")
      page.has_no_link?("Oh That Tickles")

      # click the link
      click_link('Click Me')

      # links change
      page.has_no_link?("Click Me")
      page.has_link?("Oh That Tickles")

      # and then links reset
      page.has_link?("Click Me")
      page.has_no_link?("Oh That Tickles")
    end

  end


end
