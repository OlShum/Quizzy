class Api::QuestionsController < Api::ApplicationController
  before_action :get_user, only: [:random, :count_score, :check_answer, :next_question]
  # before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json

  def random
    answered_questions_ids = @user.questions.collect { |q| q.id }
    questions = Question.all.reject { |q| answered_questions_ids.include?(q.id) }
    @question = questions.sample #(5)
    #########Как вывести только 5 вопросов

    QuestionsUser.create!(user_id: @user.id, question_id: @question.id)

    render json: @question.as_json_for_rack

    puts "==============yyyyy==============="

    # puts question
    # ActionCable.server.broadcast 'quizzroom_channel', question.as_json.to_json
    # head :ok
  end

  def count_score
    sum = 0
    @user.questions.each do |q|
      sum = sum + q.score
    end
    @user.questions.score = sum
    @user.questions.save
    score = @user.questions
    puts '++++++++++++++++++hhhhh++++++++++++++++++++'
    puts score
  end

  def check_answer
    @answers = @user.questions.collect { |q| q.answer }
    @options = @user.questions.collect { |q| q.option }
    @score = @user.questions.collect { |q| q.score }
    # current_score =
    # if options == answers
    #   score =+ score
    # end
    puts '+++++++++++++S++++++++++++++'
    puts @answers
  end

  def next_question
    format.html { redirect_to question }
    format.json { render json: question.as_json_for_rack }
  end

  # def calculate_score
  #   if @question.option = @question.answer
  #     @question.score =+ 100
  #   else
  #     @question.score = 0
  #   end
  # end

  # def check_answer
  # end

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
