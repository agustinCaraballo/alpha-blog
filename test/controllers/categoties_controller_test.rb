require 'test_helper'
class CategoriesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "sports")
    @user = User.create(username: "john", email: "john@example.com",password: "password",admin: true)
  end
  test "should get categories index" do
    get "/categories/index"
    assert_response :success
  end
  test "should get new" do
    post login_path,params: {session:{email: @user.email,password: @user.password}}
    get "/categories/new"
    assert_response :success
  end
  test "should get show" do
    get "/categories/show", params: {id: @category.id}
    assert_response :success
  end
end
