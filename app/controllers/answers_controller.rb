class AnswersController < ApplicationController
    def new
      @event = Event.find(params[:id])
      @answer = Answer.new
    end

    def show

    end

    def create
      
       @answer = Answer.new(answer_params)
       @answer.question_id = params[:question_id]
       raise @answer.question_id.inspect
        @answer.save
        redirect_to events_path, notice: "Answered Questions"


    end

  private
  def answer_params
       params.require(:answer).permit(:response, :question_id, :event_id, :user_id)
  end
end