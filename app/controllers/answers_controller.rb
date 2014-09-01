class AnswersController < ApplicationController
    def new
      @event = Event.find(params[:id])
       # @questions = Question.all
       @answer = Answer.new


       # @q = Question.all
       
       
       
       



    end

    def show

    end

    def create
        
       @answer = Answer.new(answer_params)
        # @answer.user = cu
        # @answer.user = current_user
        # @answer.event_id = @event

        @answer.save
        redirect_to events_path, notice: "Answered Questions"

        # respond_to do |format|
        #   if @answer.save
        #     format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
        #     format.json { render :show, status: :created, location: @answer }
        #   else
        #     format.html { render :new }
        #     format.json { render json: @answer.errors, status: :unprocessable_entity }
        #   end
        # end
    end

  private
  def answer_params
       params.require(:answer).permit(:response, :question, :event, :user, :event_id, :question_id, :user_id)
  end
end