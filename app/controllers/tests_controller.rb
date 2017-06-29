class TestsController < ApplicationController
  before_filter :authenticate_teacher!
  
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
        format.html { redirect_to "", notice: 'Test was successfully created.' }
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
      params.require(:test).permit(:classroom_id, :date, :topic)
  end
  
end