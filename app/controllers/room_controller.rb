class RoomController < ApplicationController
  def index
    # puts @user.to_json
    #
    #
    #
    # @questions = Question.all
    # @questions_array = []
    #
    # @questions.each do |question|
    #   @questions_array.push(question.as_json_for_rack)
    # end

    # answered_questions_ids = @user.questions.collect { |q| q.id }
    # questions = Question.all.reject { |q| answered_questions_ids.include?(q.id) }
    # @question = questions.sample
    # QuestionsUser.create!(user_id: @user.id, question_id: @question.id)
    #
    # render json: @question.as_json_for_rack
  end
end
