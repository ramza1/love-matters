class WelcomeController < BaseController

  def index
    @questions = Question.accessible_by(current_ability).recent
  end


end
