require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)

  context "creating a user" do

    setup do
      User.delete_all
    end

    should "create a user" do
      FactoryGirl.create(:user)
    end
  end
end
