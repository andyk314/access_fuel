class AnswersController < ApplicationController
    def new
       @event = Event.find params[:id]
       @qs = Question.all
       @questions = Array.new
       @questions.push (Question.find_by_event_id(@event.id))
       
       @answer = Answer.new

    end

    def show

    end

    def create
        @answer = Answer.new(answer_params)
        # @answer.user = cu
        @answer.user = current_user
        # @answer.event_id = @event



        respond_to do |format|
          if @answer.save
            format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
            format.json { render :show, status: :created, location: @answer }
          else
            format.html { render :new }
            format.json { render json: @answer.errors, status: :unprocessable_entity }
          end
        end
    end

  private
  def answer_params
       params.require(:answer).permit(:response, :question_id, :user, :user_id, :event, :event_id)
  end
end