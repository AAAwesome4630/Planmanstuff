class PagesController < ApplicationController
  before_filter :authenticate_student!, :only => [:classlink]

  def index
    if(!teacher_signed_in? && !student_signed_in? && !administrator_signed_in?)
      render :layout => 'landingPage3'
    end
  end

  def home
    
    @schoolSignUpToken = SchoolSignUpToken.new
    
    if(student_signed_in?)
      @date = params[:date] ? Date.parse(params[:date]) : Date.today
      require 'json'
      
      #@schedule = JSON.parse student_schedule("normal")
      
      @assignments = Assignment.all
      @tests = Test.all
      
      
      @srelationships = ScRelationship.all.where("student_id = ?", current_student.id )
      
      
      sclassrooms = Array.new
      
      for @relationship in @srelationships do
        sclassrooms.push(@relationship.classroom_id)
      end
      
      
      @sassignments = Assignment.where("classroom_id IN (?)", sclassrooms)
      @stests = Test.where("classroom_id IN (?)", sclassrooms)
      
      
      @assignmentss = current_student.individual_assignments
      @testss =  current_student.individual_tests
      @quizzess =  current_student.individual_quizzes
      
      
      
      
        
      
    end
    
    if (teacher_signed_in?)
      @teacher = current_teacher
      @classrooms = @teacher.classroom
      @assignments = Assignment.all
    end
  
  
    
      

  end

  def find
    
    term = params[:search]
    @classrooms = Classroom.search(term)
    @schools = School.search(term)
    
  end

  def profile
  end
  
  def classroom
    
    if(Classroom.find_by_id(params[:id]))
      @classroom_id = params[:id]
      @classroom = Classroom.find_by_id(params[:id])
      @nOS = @classroom.numberOfStudents
      @teacher_id = @classroom.teacher_id
      @name = @classroom.name
      @subject = @classroom.subject
      @link = "https://my-planner-app-cloned18-aawesome4630.c9users.io/classroom/"+params[:id].to_s+"/join/"
      
      if(teacher_signed_in?)
        if(current_teacher.id == @teacher_id)
        @tstatus = true
        @link = "https://my-planner-app-cloned18-aawesome4630.c9users.io/classroom/"+params[:id].to_s+"/join/"
    
        else
          @tstatus = false
        end
      end
    

      @t_filez = TFile.all.where("classroom_id = ?", Classroom.find_by_id(params[:id]).id)
      
      @crelationships = ScRelationship.all.where("classroom_id = ?", Classroom.find_by_id(params[:id]).id )
      
      if(student_signed_in?)
        

        for relationship in @crelationships do
                       
            if(relationship.student_id == current_student.id)
              @status = true
              @scs_relationship = relationship
            else
              @status = false

            end
        
        
        end
        
      end
      
    else
      redirect_to root_path, :notice => 'Classroom Does not exist!!!'
    end
    
  
    
    @sc_relationship = ScRelationship.new
    
    @assignment = Assignment.new
    
    @test = Test.new
    
    @t_file = TFile.new
    
    @announcement = Announcement.new
      
    
  end
  
  def classlink
    
       @classroom = Classroom.find_by_id(params[:id])
       for student in @classroom.students do
         if student == current_student.id
           joined = true
         end
       end
         if joined
           redirect_to @classroom, :notice => "You are already part of this classroom"
         else
           if(@classroom.password_digest.delete('.').delete('/') == params[:token])
             @classroom_id = @classroom.id
             @s_id = current_student.id
            @sc_relationship = ScRelationship.new(classroom_id: @classroom_id, student_id: @s_id)
            respond_to do |format|
        if @sc_relationship.save
          @classroom.students.push(current_student.id)
          current_student.classrooms.push(@classroom.id.to_i)
          @classroom.save
          current_student.save
          find_classroom_assignments(@classroom_id, @s_id)
          find_classroom_tests(@classroom_id, @s_id)
          find_classroom_quizzes(@classroom_id, @s_id)
          format.html { redirect_to @classroom, notice: 'Relationship was successfully created.' }
        else
          format.html { redirect_to "", notice: 'error not created' }
        end
      end
           else
             redirect_to @classroom, notice: "Wrong Password"
           end
         end
  

  end
  

  
  
  def astudent_schedule(weekend)
    @json_string_start = "{\"assignments\":"
    @json_string_middle = ", \"tests\":"
    @json_string_end = "}"
    if(weekend == "normal")
      for classroom in current_student.classrooms do
        @classroom = Classroom.find_by_id(classroom)
        for assignment in @classroom.assignments.all do
          if !(assignment.finished)
            @time = days_btwn(assignment)
            if (@time==false)
              #do nothing
            else
              @json_string_start = @json_string_start + "[\"assignment_name\":\"" + @assignment.name + "\", \"recommended time\":" + @time.to_s + "]"
            end
          end
        end
      end
        @json_string = @json_string_start + @json_string_end
      return @json_string 
    end
    
    
    def days_btwn(assignment)
      @dif = (assignemnt.due_date.to_s - Date.today.to_s)
      if(@dif <= assignment.rec_days)
        assignment.rec_days = @dif
        assignment.save
        @time = assignment.eta/assignment.rec_days
        return @time
      else
        return false
      end
    end
    
  end
  
  def authenticate_student!
    if (teacher_signed_in?)
      sign_out current_teacher
      super
    elsif (administrator_signed_in?)
      sign_out current_administrator
      super
    else
      super
    end
  end
  
  def find_classroom_tests(classroomid, studentid)
    Classroom.find_by_id(classroomid).tests.all.each do |dtest|
      @date_dif = dtest.date.mjd - Date.today.mjd+1
      if (@date_dif >= dtest.rec_days)
        @i = IndividualTests.new(test_id: dtest.id, time_remaining: dtest.eta, rec_days: dtest.rec_days, student_id: studentid, classroom_id: classroomid )
        @i.save
      elsif(@date_dif >= 0)
        @i = IndividualTests.new(test_id: dtest.id, time_remaining: dtest.eta, rec_days: @date_dif, student_id: studentid, classroom_id: classroomid )
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
  

end
