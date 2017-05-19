require 'test_helper'
  class UserSignupTest < ActionDispatch::IntegrationTest
    def setup
      @user = User.new(username: "john", email: "john@example.com",password: "password",admin: true)
      @user2 = User.new(username: "carlos", email: "carlos@example.com",password: "password22",admin: true)
    end
    test "user should get sign up page" do
      get "/signup"
      assert_response :success
    end
    test "user should be able to sign up" do
      get "/signup"
      assert_response :success
      post users_path,params: {user:{username: @user.username,email: @user.email,password: @user.password}}
      follow_redirect!
      assert_match "#{@user.username}", response.body
    end
    test "signup should fail with no username, password or email" do
      post users_path,params: {user:{username:"",email: "",password: ""}}
      assert_match "prohibited the item from been saved", response.body
    end
  end
