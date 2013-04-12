class QuestionsController < BaseController
  load_and_authorize_resource
  def index
    @questions = Question.accessible_by(current_ability).recent

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.json
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.json
  def create
    if params[:email].present?
      redirect_to root_url,
                  :notice => "Your feedback message was caught by the spam filter because you filled in the invisible email field. Please try again without filling in the false email field and let me know that this happened."
    else
    @question = Question.new(params[:question])
    @question.user = current_user if current_user
    if params[:question][:answer].present?
      @question.answered_by = current_user.id
    end

    respond_to do |format|
      if @question.save
        Question.send_emails(@question) unless @question.user.present?
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.json
  def update
    @question = Question.find(params[:id])
    if params[:question][:answer].present?
      @question.answered_by = current_user.id
    end

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end
end
