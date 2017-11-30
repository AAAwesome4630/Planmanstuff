class QuizzesController < ApplicationController
    before_filter :authenticate_teacher!
  
  def edit
    @quiz = Quiz.find_by_id(params[:id])
  end
  
  def update
     @quiz = Quiz.find_by_id(params[:id])
     @classroom = Classroom.find_by_id(@quiz.classroom_id)
    respond_to do |format|
      if @quiz.update!(quiz_params)
        format.html { redirect_to @classroom, notice: 'Quiz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def create
    @quiz = Quiz.new(quiz_params)
    respond_to do |format|
      if @quiz.save
        @classroom = Classroom.find_by_id(@quiz.classroom_id)
        create_individual_quizzes(@quiz)
        format.html { redirect_to @classroom, notice: 'Quiz was successfully created.' }
      else
        format.html { redirect_to "", notice: 'error not created' }
      end
    end
  end
  
  def destroy
    @quiz = Quiz.find_by_id(params[:id])
    @classroom = Classroom.find_by_id(@quiz.classroom_id)
    @quiz.destroy
    respond_to do |format|
      if @quiz.save

        format.html { redirect_to @classroom, notice: 'Quiz was successfully deleted.' }
        format.json { head :no_content }
      end
    end
  end
  private 
  
  def quiz_params
      params.require(:quiz).permit(:classroom_id, :date, :topic, :description, :eta)
  end
  
  def find_classroom_quizzes(classroom_id, studentid)
    Classroom.find_by_id(classroom_id).quizzes.all.each do |quiz|
      @date_dif = quiz.date - Date.today
      if (@date_dif >= quiz.rec_days)
        @i = IndividualQuiz.new(quiz_id: quiz.id, time_remaining: quiz.eta, rec_days: quiz.rec_days, student_id: studentid )
        @i.save
      elsif(@date_dif > 0)
        @i = IndividualQuiz.new(quiz_id: quiz.id, time_remaining: quiz.eta, rec_days: @date_dif, student_id: studentid )
        @i.save
      end
    end
  end
  
  def create_individual_quizzes(quiz)
    for studentid in Classroom.find_by_id(quiz.classroom_id).students do
      @i = IndividualQuiz.new(test_id: quiz.id, time_remaining: quiz.eta, rec_days: quiz.rec_days, student_id: studentid )
      @i.save
    end
  end
  
end
