class ScRelationshipsController < ApplicationController
  before_filter :authenticate_student!, :only =>[:create]
  require 'date'


  def create
    @classroom_id = sc_params[:classroom_id]
    @classroom = Classroom.find_by_id(@classroom_id)
    @no_class_pass = (@classroom.password_digest != nil)
    @authentic = true
    if(@class_pass)
      @password = params[:password]
      if (@classroom.authenticate(@password) == false)
        @authentic = false
        redirect_to @classroom, notice: "Wrong Password"
      end
    end
    
    if (@authentic)
      @sc_relationship = ScRelationship.new(sc_params)
      @classroom_id = sc_params[:classroom_id]
      @classroom = Classroom.find_by_id(@classroom_id)
      @sc_relationship.student_id = current_student.id
      respond_to do |format|
        if @sc_relationship.save
          find_classroom_assignments(@sc_relationship.classroom_id, @sc_relationship.student_id)
          @classroom.students.push(current_student.id)
          current_student.classrooms.push(@classroom_id.to_i)
          @classroom.save
          current_student.save
          find_classroom_tests(@classroom_id, current_student.id)
          find_classroom_quizzes(@classroom_id, current_student.id)
          format.html { redirect_to @classroom, notice: 'Relationship was successfully created.' }
        else
          format.html { redirect_to "", notice: 'error not created' }
        end
      end
    end
  end
  
  def destroy
    @ScRelationship = ScRelationship.find_by_id(params[:sc_relationship_id])
    @classroom_id = @ScRelationship.classroom_id
    @student_id = @ScRelationship.student_id
    @classroom = Classroom.find_by_id(@classroom_id)
    @classroom.students.delete(@student_id)
    @s = Student.find_by_id(@student_id)
    @s.classrooms.delete(@classroom_id)
    @classroom.save
    @s.save
    @ScRelationship.destroy
    respond_to do |format|
      if @ScRelationship.save
        delete_individual_assignments(@classroom_id, @student_id)
        delete_individual_tests(@classroom_id, @student_id)
        delete_individual_quizzes(@classroom_id, @student_id)
        format.html { redirect_to @classroom, notice: 'Relationship was successfully deleted.' }
        format.json { head :no_content }
      end
    end
  end
  
  private
  def sc_params
      params.require(:sc_relationship).permit(:classroom_id)
  end
  
  def find_classroom_tests(classroomid, studentid)
    for @t in Classroom.find_by_id(classroomid).tests.all.each do 
      @date_dif = @t.date.mjd - Date.today.mjd+1
      if (@date_dif >= @t.rec_days)
        @i = IndividualTests.new(test_id: @t.id, time_remaining: @t.eta, rec_days: @t.rec_days, student_id: studentid, classroom_id: classroomid )
        @i.save
      elsif(@date_dif >= 0)
        @i = IndividualTests.new(test_id: @t.id, time_remaining: @t.eta, rec_days: @date_dif, student_id: studentid, classroom_id: classroomid )
        @i.save
      end
    end
  end
  
  def find_classroom_assignments(classroomid, studentid)
    for @a in Classroom.find_by_id(classroomid).assignments.all.each do
      @date_dif = @a.due_date.mjd - Date.today.mjd+1
      if (@date_dif >= @a.rec_days)
        @i = IndividualAssignment.new(assignment_id: @a.id, time_remaining: @a.eta, rec_days: @a.rec_days, student_id: studentid, classroom_id: classroomid )
        @i.save
      elsif(@date_dif >= 0)
        @i = IndividualAssignment.new(assignment_id:@a.id, time_remaining: @a.eta, rec_days: @date_dif, student_id: studentid, classroom_id: classroomid )
        @i.save
      end
    end
  end
  
  def find_classroom_quizzes(classroomid, studentid)
    Classroom.find_by_id(classroomid).quizzes.all.each do |quiz|
      @date_dif = quiz.date.mjd - Date.today.mjd+1
      if (@date_dif >= quiz.rec_days)
        @i = IndividualQuiz.new(quiz_id: quiz.id, time_remaining: quiz.eta, rec_days: quiz.rec_days, student_id: studentid, classroom_id: classroomid )
        @i.save
      elsif(@date_dif >= 0)
        @i = IndividualQuiz.new(quiz_id: quiz.id, time_remaining: quiz.eta, rec_days: @date_dif, student_id: studentid,  classroom_id: classroomid )
        @i.save
      end
    end
  end
  
  def delete_individual_assignments(classroomid, studentid)
    
    for @ia in Student.find_by_id(studentid).individual_assignments.all do
      if @ia.classroom_id == classroomid
        @ia.destroy
        @ia.save
      end
    end
  end
  
  def delete_individual_tests(classroomid, studentid)
    
    for @it in Student.find_by_id(studentid).individual_tests.all do
      if @it.classroom_id == classroomid
        @it.destroy
        @it.save
      end
    end
  end
  
  def delete_individual_quizzes(classroomid, studentid)
    
    for @iq in Student.find_by_id(studentid).individual_quizzes.all do
      if @iq.classroom_id == classroomid
        @iq.destroy
        @iq.save
      end
    end
  end
    
  
  
  
end