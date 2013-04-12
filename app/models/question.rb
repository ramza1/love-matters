class Question < ActiveRecord::Base
  belongs_to :user
  attr_accessible :answer, :email, :name, :question, :website, :user_id

  validates :question, presence: true, uniqueness: true
  validates :name, :email, presence: true, unless: :moderator
  validates_presence_of :answer, message: "this question and try again", if: :moderator
  scope :answered_questions, -> {where("answer not in (?)", "nil")}
  scope :recent, order("created_at desc")

  def self.send_emails(id)
    find(id).send_emails
  end


  def send_emails
    User.find_each do |user|
      QuestionMailer.notice(self, user).deliver
    end
  end

  def publish_question

    self.update_attribute(:published, true)  if answer.present?

  end

  private

  def moderator
    user_id.present?
  end

end
