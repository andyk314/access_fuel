class AnswersController < ApplicationController
    def new
      # @question = Question.find params[:question_id]
       @answer = Answer.new
    end

    def show
    end

    def create
        @answer = Answer.new(answer_params)
        # @answer.save 

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
       params.require(:answer).permit(:response, :question_id)
  end
end