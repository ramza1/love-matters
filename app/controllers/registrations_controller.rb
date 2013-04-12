class RegistrationsController < Devise::RegistrationsController
  before_filter :ensure_administrators
end
