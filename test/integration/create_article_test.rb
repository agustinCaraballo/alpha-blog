require 'test_helper'
  class CreateArticleTest < ActionDispatch::IntegrationTest
    def setup
      @user = User.create(username: "john", email: "john@example.com",password: "password",admin: true)
    end
  test "get new articles form and create article" do
    post login_path,params: {session:{email: @user.email,password: @user.password}}
    get "/articles/new"
    assert_response :success
    assert_difference 'Article.count',1 do
      post articles_path, params: {article:{title: "Sports",description: "This is a sports article"}}
      follow_redirect!
    end
    assert_response :success
    assert_match "This is a sports article", response.body
  end
  test "should redirect to main page when create when admin not logged in" do
    assert_no_difference 'Article.count' do
      post articles_path, params: {article:{title: "Sports",description: "This is a sports article"}}
    end
    assert_redirected_to root_path
  end
end
