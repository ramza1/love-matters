ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

require 'test/unit/diff'
require 'test/unit/ui/console/testrunner'

class Test::Unit::UI::Console::TestRunner
  def guess_color_availability
    true
  end
end

class ActionController::TestCase
  include Devise::TestHelpers

  def login_as_user
    @jane = FactoryGirl.create(:user)
    @jane.reload

    sign_in :user, @jane
    @controller.stubs(:current_user).returns(@jane)
  end

  def logout_users
    sign_out :user
    @controller.stubs(:current_user).returns(nil)
  end

end
