require 'test_helper'

class QuestionsControllerTest < ActionController::TestCase

  setup do
    login_as_user
    @question = FactoryGirl.create(:question)
  end

  should "go to registration page if there is no user in the system" do
    User.delete_all
    sign_out :user
    get :index
    assert_response :redirect
    assert_redirected_to new_user_registration_path
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create question by guest user" do
    Question.delete_all
    assert_difference('Question.count') do
      post :create, question: FactoryGirl.attributes_for(:question)
    end

    assert_redirected_to question_path(assigns(:question))
  end

  test "should send all moderators an email when there is a new question by guest users" do
    question = Question.last
    Question.send_emails(question)
  end

  test "should answer question by moderator" do
    put :update, id: Question.last, question: { answer: "my answer"}
    assert_equal @jane.id, Question.last.answered_by
    assert_redirected_to question_path(assigns(:question))
  end

  test "should check if a question is answered and publish it" do
    put :update, id: Question.last, question: { answer: @question.answer}
    assert_redirected_to question_path(assigns(:question))
    assert Question.last.answer.present?
  end


  test "should create question by moderator and answered" do
    Question.delete_all
    assert_difference('Question.count') do
      post :create, question: { answer: @question.answer, question: @question.question}
    end
    assert_equal @jane.id, Question.last.user_id
    assert Question.last.answer.present?
    assert_redirected_to question_path(assigns(:question))
  end



  test "should show question" do
    get :show, id: @question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @question
    assert_response :success
  end

  test "should update question" do
    put :update, id: @question, question: { question: @question.question }
    assert_redirected_to question_path(assigns(:question))
  end

  test "should destroy question" do
    assert_difference('Question.count', -1) do
      delete :destroy, id: @question
    end

    assert_redirected_to questions_path
  end

end
