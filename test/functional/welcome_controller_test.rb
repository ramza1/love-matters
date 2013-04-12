require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  setup do
    login_as_user
    #@question = FactoryGirl.create(:question)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

end
