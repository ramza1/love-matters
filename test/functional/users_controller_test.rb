require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    login_as_user
  end

  should "require user login" do
    sign_out :user
    get :index
    assert_response :redirect
    assert_redirected_to user_session_path
  end

  should "go to registration page if there is no user in the system" do
    User.delete_all
    sign_out :user
    get :index
    assert_response :redirect
    assert_redirected_to new_user_registration_path
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should show moderator" do
    get :show, id: @controller.current_user
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jane
    assert_response :success
  end

  test "should update user" do
    put :update, id: @jane, user: { first_name: @jane.first_name }
    assert_redirected_to user_path(@jane)
  end

  test "should destroy user" do
    @tunde = FactoryGirl.create(:user)
    assert_difference('User.count', -1) do
      delete :destroy, id: @tunde
    end

    assert_redirected_to users_path
  end

  context "creating an moderator" do

    should "create the user" do
      assert_difference('User.count') do
        post :create, user: FactoryGirl.attributes_for(:user)
      end
    end

  end
end
