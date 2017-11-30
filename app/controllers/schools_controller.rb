class SchoolsController < ApplicationController
  before_filter :check_token, :only => [:sign_up]
  
  
  def index

      @schools = School.search(params[:term])

      render json: @schools.map(&:name)
      
  end


  def show
    
  end
  
  def sign_up
    if (teacher_signed_in?)
      sign_out current_teacher
    elsif (administrator_signed_in?)
      sign_out current_administrator
    elsif(student_signed_in?)
      sign_out current_student
    end
    @school = School.new
    @s = SchoolSignUpToken.find_by_id(params[:id])
    if params[:token].to_s == @s.token
     @valid = true

    else
     redirect_to root_path
    end
    
    
  end
  def update
     @school = School.find_by_id(params[:id])
    respond_to do |format|
      if @assginment.update!(school_params)
        format.html { redirect_to "", notice: 'School was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def create
    @school = School.new(school_params)
    respond_to do |format|
      if @school.save
        @s = SchoolSignUpToken.find_by_id(params[:sign_up_token_id].to_i)
        @s.destroy
        @s.save
        format.html { redirect_to "", notice: 'School was successfully created.' }
      else
        format.html { redirect_to "", notice: 'error not created' }
      end
    end
  end
  
  
  def destroy
    @school = School.find_by_id(params[:id])
    @school.destroy
    respond_to do |format|
      if @school.save
        format.html { redirect_to "", notice: 'School was successfully deleted.' }
        format.json { head :no_content }
      end
    end
  end
  private
   
  def school_params
      params.require(:school).permit(:name, :address, :type, :city, :state, :country, :mascot, :website, :NCES_id, :password, :password_confirmation)
  end
  
  

  def check_token
    redirect_to root_path, :flash => {:error => "Bad link"} if SchoolSignUpToken.where("token = ? and expires_at > ?", params[:token], Time.now).nil?
    redirect_to root_path, :flash => {:error => "Bad link"} if SchoolSignUpToken.find_by_id(params[:id]).nil?
  end
end