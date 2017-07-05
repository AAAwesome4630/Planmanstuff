class ScRelationshipsController < ApplicationController
  before_filter :authenticate_student!
  require 'date'


  def create
    @classroom_id = sc_params[:classroom_id]
    @classroom = Classroom.find_by_id(@classroom_id)
    @password = params[:password]
    if (@classroom.authenticate(@password) == false)
      redirect_to @classroom, notice: "Wrong Password"
    else
      @sc_relationship = ScRelationship.new(sc_params)
      @classroom_id = sc_params[:classroom_id]
      @classroom = Classroom.find_by_id(@classroom_id)
      @sc_relationship.student_id = current_student.id
      respond_to do |format|
        if @sc_relationship.save
          @classroom.students.push(current_student.id)
          current_student.classrooms.push(@classroom_id)
          @classroom.save
          current_student.save
          find_classroom_assignments(@classroom_id, current_student.id)
          find_classroom_tests(@classroom_id, current_student.id)
          find_classroom_quizzes(@classroom_id, current_student.id)
          format.html { redirect_to "", notice: 'Relationship was successfully created.' }
        else
          format.html { redirect_to "", notice: 'error not created' }
        end
      end
    end
  end
  
  def destroy
    @ScRelationship = ScRelationship.find_by_id(params[:sc_relationship_id])
    @classroom_id = @ScRelationship.classroom_id
    @classroom = Classroom.find_by_id(@classroom_id)
    @classroom.students.delete(current_student.id)
    current_student.classrooms.delete(@classroom_id.to_s)
    @classroom.save
    current_student.save
    @ScRelationship.destroy
    respond_to do |format|
      if @ScRelationship.save
        delete_individual_assignments(@classroom_id, current_student.id)
        delete_individual_tests(@classroom_id, current_student.id)
        delete_individual_quizzes(@classroom_id, current_student.id)
        format.html { redirect_to "", notice: 'Relationship was successfully deleted.' }
        format.json { head :no_content }
      end
    end
  end
  
  private
  def sc_params
      params.require(:sc_relationship).permit(:classroom_id)
  end
  
  def find_classroom_tests(classroomid, studentid)
    Classroom.find_by_id(classroomid).tests.all.each do |dtest|
      @date_dif = dtest.date.mjd - Date.today.mjd
      if (@date_dif >= dtest.rec_days)
        @i = IndividualTests.new(test_id: dtest.id, time_remaining: dtest.eta, rec_days: dtest.rec_days, student_id: studentid, classroom_id: classroomid )
        @i.save
      elsif(@date_dif > 0)
        @i = IndividualTests.new(test_id: dtest.id, time_remaining: dtest.eta, rec_days: @date_dif, student_id: studentid, classroom_id: classroomid )
        @i.save
      end
    end
  end
  
  def find_classroom_assignments(classroomid, studentid)
    Classroom.find_by_id(classroomid).assignments.all.each do |assignment|
      @date_dif = assignment.due_date.mjd - Date.today.mjd
      if (@date_dif >= assignment.rec_days)
        @i = IndividualAssignment.new(assignment_id: assignment.id, time_remaining: assignment.eta, rec_days: assignment.rec_days, student_id: studentid, classroom_id: classroomid )
        @i.save
      elsif(@date_dif > 0)
        @i = IndividualAssignment.new(assignment_id: assignment.id, time_remaining: assignment.eta, rec_days: @date_dif, student_id: studentid, classroom_id: classroomid )
        @i.save
      end
    end
  end
  
  def find_classroom_quizzes(classroomid, studentid)
    Classroom.find_by_id(classroomid).quizzes.all.each do |quiz|
      @date_dif = quiz.date.mjd - Date.today.mjd
      if (@date_dif >= quiz.rec_days)
        @i = IndividualQuiz.new(quiz_id: quiz.id, time_remaining: quiz.eta, rec_days: quiz.rec_days, student_id: studentid, classroom_id: classroomid )
        @i.save
      elsif(@date_dif > 0)
        @i = IndividualQuiz.new(quiz_id: quiz.id, time_remaining: quiz.eta, rec_days: @date_dif, student_id: studentid,  classroom_id: classroomid )
        @i.save
      end
    end
  end
  
  def delete_individual_assignments(classroomid, studentid)
    
    Student.find_by_id(studentid).individual_assignments.all do |i_assignment|
      if i_assignment.classroom_id = classroomid
        i_assignment.destroy
        i_assignment.save
      end
    end
  end
  
  def delete_individual_tests(classroomid, studentid)
    
    Student.find_by_id(studentid).individual_tests.all do |i_test|
      if i_test.classroom_id = classroomid
        i_test.destroy
        i_test.save
      end
    end
  end
  
  def delete_individual_quizzes(classroomid, studentid)
    
    Student.find_by_id(studentid).individual_quizs.all do |i_quiz|
      if i_quiz.classroom_id = classroomid
        i_quiz.destroy
        i_quiz.save
      end
    end
  end
    
  
  
  
end