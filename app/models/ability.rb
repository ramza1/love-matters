class Ability
  include CanCan::Ability

  def initialize(user)


    can :read, Question, ["answer not in (?)", "nil"] do |question|
        question.answer.present?
    end

    can :create, Question

    if user
      can :manage, :all
    end

  end
end
