

class ClassroomsController < ApplicationController
  
before_filter :authenticate_teacher!, :except => [:show, :index]
  
  def index
    
    @classrooms = Classroom.all.order('numberOfStudents DESC')
    @classrooms = @classrooms.search(params[:search]) if params[:search].present?
    redirect_to find_path
  end
  
  def show
    
    
    if(Classroom.find_by_id(params[:id]))
      
      @classroom = Classroom.find_by_id(params[:id])
      @classroom_id = @classroom.id
      @nOS = @classroom.students.length
      @teacher_id = @classroom.teacher_id
      @name = @classroom.name
      @subject = @classroom.subject
      @teacher = Teacher.find_by_id(@teacher_id)
      @class_pass = (@classroom.password_digest != nil)
      
      if(teacher_signed_in?)
        
        
        if(current_teacher.id == @teacher_id)
          @tstatus = true
          if(@class_pass)
            @link = "https://my-planner-app-cloned-23-aawesome4630.c9users.io/classrooms/"+params[:id].to_s+"/join/"+@classroom.password_digest.delete('.').delete('/')
          end
        else
          @tstatus = false
        end
      end
    

      @t_filez = TFile.all.where("classroom_id = ?", Classroom.find_by_id(params[:id]).id)
      
      @crelationships = ScRelationship.all.where("classroom_id = ?", Classroom.find_by_id(params[:id]).id )
      
      if(student_signed_in?)

        for class_id in current_student.classrooms do
          @status = false
            if(class_id.to_i == params[:id].to_i)
              @status = true
              @scs_relationship = ScRelationship.where("classroom_id = ? AND student_id = ?",@classroom_id, current_student.id).first
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
    
    @quiz = Quiz.new
      
  end

  def new
    @classroom = current_teacher.classrooms.build
  end

  def create
    if(classroom_params[:password] != classroom_params[:password_confirmation])
      redirect_to newclassroom_path, notice: 'Password and Confirmation do not match.'
    else
    #   if(classroom_params[:password] == "")
    #     @classroom = current_teacher.classroom.build(no_pass_params)
    #     @classroom.password_digest = ""
    #     @classroom.teacher_id = current_teacher.id
    #     respond_to do |format|
    #       if @classroom.save
    #         current_teacher.classrooms.push(@classroom.id)
    #         current_teacher.save
    #         format.html { redirect_to @classroom, notice: 'classroom was successfully created.' }
    #       else
    #         format.html { redirect_to "", notice: 'error not created' }
    #       end
    #     end
    #   else
        @classroom = current_teacher.classroom.build(classroom_params)
        @classroom.teacher_id = current_teacher.id
        respond_to do |format|
          if @classroom.save
            current_teacher.classrooms.push(@classroom.id)
            current_teacher.save
            format.html { redirect_to @classroom, notice: 'classroom was successfully created.' }
          else
            format.html { redirect_to "", notice: 'error not created' }
          end
        # end
      end
    end
  end

  def destroy 
    
    @classroom = Classroom.find_by_id(params[:id])
    @relationships = ScRelationship.all.where("classroom_id = ?", @classroom.id )
    for relationship in @relationships do
      @student = Student.find_by_id(relationship.student_id)
      @student.classrooms.delete(params[:id])
      @student.save
      relationship.destroy
      relationship.save
    end
    @classroom.destroy
    respond_to do |format|
      if @classroom.save
        format.html { redirect_to "", notice: 'Classroom was successfully deleted.' }
        format.json { head :no_content }
      end
    end
    
  end
  
  
  def edit 
    @classroom = Classroom.find_by_id(params[:id])
  end
  def update
    
     @classroom = Classroom.find_by_id(params[:id])
     
    respond_to do |format|
      if @classroom.update!(classroom_params)
        format.html { redirect_to @classroom, notice: 'Classroom was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def classroom_params
    params.require(:classroom).permit(:name, :subject, :description, :password, :password_confirmation)
  end
  
  def no_pass_params
    params.require(:classroom).permit(:name, :subject, :description)
  end
  
  def getAssignments(date)
    
    return Classroom.find_by_id(params[:id]).find_by_due_date(date)
    
  end
  
  def getTests()
    
  end
  
  def getQuizzes()
    
  end
  
  def getAnnouncements()
    
  end
  
  def authenticate_teacher!
    if (student_signed_in?)
      sign_out current_student
      super
    elsif (administrator_signed_in?)
      sign_out current_administrator
      super
    else
      super
    end
  end
end