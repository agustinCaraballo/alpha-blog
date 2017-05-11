require 'test_helper'
  class CreateCategoriesTest < ActionDispatch::IntegrationTest
  test "get new categories form and create category" do
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
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: {category:{name: ""}}
    end
    assert_response :success
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
end
