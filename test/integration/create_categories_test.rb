require 'test_helper'
  class CreateCategoriesTest < ActionDispatch::IntegrationTest
    def setup
      @user = User.create(username: "john", email: "john@example.com",password: "password",admin: true)
    end
  test "get new categories form and create category" do
    post login_path,params: {session:{email: @user.email,password: @user.password}}
    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count',1 do
      post categories_path, params: {category:{name: "sports"}}
      follow_redirect!
    end
    assert_response :success
    assert_match "sports", response.body
  end
  test "invalid category submission results in failing" do
    post login_path,params: {session:{email: @user.email,password: @user.password}}
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: {category:{name: ""}}
    end
    assert_response :success
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
  test "should redirect create when admin not logged in" do
    assert_no_difference 'Category.count' do
      post categories_path, params: {category:{name: "sports"}}
    end
    assert_redirected_to categories_path
  end
end
