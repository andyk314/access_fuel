Class AnswersController < ApplicationController
    def new
       @question = Question.find params[:question_id]
       @answer = Answer.new
    end

    def create
        @answer = Answer.new(answer_params)
        @answer.save
    end

    private

    def answer_params
       params.require(:answer).permit(:your, :answer, :params, :question_id)
    end
end
