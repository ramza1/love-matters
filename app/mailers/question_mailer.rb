class QuestionMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.question_mailer.notice.subject
  #
  def notice(question, moderator)
    @moderator = moderator
    @question = question

    mail to: moderator.email, subject: "A new question is waiting your responce", from: "Love Matters"
  end
end
