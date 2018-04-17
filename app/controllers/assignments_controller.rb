class AssignmentsController < ApplicationController
  before_filter :authenticate_teacher!

  def edit
    @assignment = Assignment.find_by_id(params[:id])
  end
  
  def update
     @assignment = Assignment.find_by_id(params[:id])
     @classroom = Classroom.find_by_id(@assignment.classroom_id)
    respond_to do |format|
      if @assignment.update!(assignment_params)
        format.html { redirect_to @classroom, notice: 'Assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def create
    @assignment = Assignment.new(assignment_params)
    respond_to do |format|
      if @assignment.save
        @classroom = Classroom.find_by_id(@assignment.classroom_id)
        create_individual_assignments(@assignment,@classroom.id)
        format.html { redirect_to @classroom, notice: 'Assignment was successfully created.' }
      else
        format.html { redirect_to "", notice: 'error not created' }
      end
    end
  end
  
  def destroy
    @assignment = Assignment.find_by_id(params[:id])
    @classroom = Classroom.find_by_id(@assignment.classroom_id)
    @assigment.destroy
    respond_to do |format|
      if @assignment.save
        
        format.html { redirect_to @classroom, notice: 'Assignment was successfully deleted.' }
        format.json { head :no_content }
      end
    end
  end
  private
  
  def assignment_params
      params.require(:assignment).permit(:classroom_id, :due_date, :name, :eta, :rec_days, :description)
  end
  
  def find_classroom_assignments(classroomid, studentid)
    Classroom.find_by_id(classroomid).assignments.all.each do |assignment|
      @date_dif = assignment.due_date.to_s - Date.today.to_s
      if (@date_dif >= assignment.rec_days)
        @i = IndividualAssignment.new(assignment_id: assignment.id, time_remaining: assignment.eta, rec_days: assignment.rec_days, student_id: studentid, classroom_id: classroomid )
        @i.save
      elsif(@date_dif > 0)
        @i = IndividualAssignment.new(assignment_id: assignment.id, time_remaining: assignment.eta, rec_days: @date_dif, student_id: studentid,classroom_id: classroomid )
        @i.save
      end
    end
  end
  
  def create_individual_assignments(assignment,classroomid)
    for studentid in Classroom.find_by_id(classroomid).students do
      @i = IndividualAssignment.new(assignment_id: assignment.id, time_remaining: assignment.eta, rec_days: assignment.rec_days, student_id: studentid, classroom_id: classroomid )
      @i.save
    end
  end
    
  
end