class BaseController < ApplicationController
  before_filter :check_for_moderators
  private

  def check_for_moderators
    redirect_to new_user_registration_path unless User.any?
  end
end
