require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  should belong_to(:user)
  should validate_presence_of(:question)
  should validate_presence_of(:name)

  context "creating a question" do

    setup do
      Question.delete_all
    end

    should "create a question" do
      FactoryGirl.create(:question)
    end
  end
end
