class TestsController < ApplicationController
  before_filter :authenticate_teacher!
  require 'date'
  
  def edit
    @test = Test.find_by_id(params[:id])
  end
  
  def update
     @test = Test.find_by_id(params[:id])
     @classroom = Classroom.find_by_id(@test.classroom_id)
    respond_to do |format|
      if @test.update!(test_params)
        format.html { redirect_to @classroom, notice: 'Test was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def create
    @test = Test.new(test_params)
    respond_to do |format|
      if @test.save
        @classroom = Classroom.find_by_id(@test.classroom_id)
        create_individual_tests(@test)
        format.html { redirect_to @classroom, notice: 'Test was successfully created.' }
      else
        format.html { redirect_to "", notice: 'error not created' }
      end
    end
  end
  
  def destroy
    @test = Test.find_by_id(params[:id])
    @classroom = Classroom.find_by_id(@test.classroom_id)
    @test.destroy
    respond_to do |format|
      if @test.save
        format.html { redirect_to @classroom, notice: 'Test was successfully deleted.' }
        format.json { head :no_content }
      end
    end
  end
  private 
  
  def test_params
      params.require(:test).permit(:classroom_id, :date, :topic, :description, :eta, :rec_days)
  end
  
  def find_classroom_tests(classroom_id, studentid)
    Classroom.find_by_id(classroom_id).tests.all.each do |dtest|
      @date_dif = dtest.date - Date.today
      if (@date_dif >= dtest.rec_days)
        @i = IndividualTest.new(test_id: dtest.id, time_remaining: dtest.eta, rec_days: dtest.rec_days, student_id: studentid )
        @i.save
      elsif(@date_dif > 0)
        @i = IndividualTest.new(test_id: dtest.id, time_remaining: dtest.eta, rec_days: @date_dif, student_id: studentid )
        @i.save
      end
    end
  end
  
  def create_individual_tests(dtest)
    for studentid in Classroom.find_by_id(dtest.classroom_id).students do
      @i = IndividualTest.new(test_id: dtest.id, time_remaining: dtest.eta, rec_days: dtest.rec_days, student_id: studentid )
      @i.save
    end
  end
    
    
  
end