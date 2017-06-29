class ScRelationshipsController < ApplicationController
  before_filter :authenticate_student!


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
        format.html { redirect_to "", notice: 'Relationship was successfully deleted.' }
        format.json { head :no_content }
      end
    end
  end
  
  private
  def sc_params
      params.require(:sc_relationship).permit(:classroom_id)
  end
end