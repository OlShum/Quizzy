class Api::QuestionsController < Api::ApplicationController
  before_action :get_user, only: :random
  # before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    # @questions = Question.all
    # questions_array = []
    #
    # @questions.each do |question|
    #   questions_array << question.as_json_for_rack
    # end
    #
    # render json: questions_array
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @question = Question.find(params[:id])
    render json: @question.as_json_for_rack
  end

  def random
    answered_questions_ids = @user.questions.collect { |q| q.id }
    questions = Question.all.reject { |q| answered_questions_ids.include?(q.id) }
    question = questions.sample
    QuestionsUser.create!(user_id: @user.id, question_id: question.id)

    render json: question.as_json_for_rack

    puts "==============yyyyy==============="
    puts QuestionsUser

    # puts question
    # ActionCable.server.broadcast 'quizzroom_channel', question.as_json.to_json
    # head :ok
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_question
    #   @question = Question.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def question_params
      params.require(:question).permit(:option, :answer)
    end

    def get_user
      guest_uuid = cookies[:guest_uuid]
      @user = User.where(guest_uuid: guest_uuid).last
    end
end
