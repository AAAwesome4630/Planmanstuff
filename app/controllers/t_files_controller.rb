class TFilesController < ApplicationController
  before_filter :authenticate_teacher!

  
  def create
    @t_file = TFile.new(tf_params)
    respond_to do |format|
      if @t_file.save
        @classroom = Classroom.find_by_id(@t_file.classroom_id)
        format.html { redirect_to "", notice: 'TFile was successfully created.' }
      else
        format.html { redirect_to "", notice: 'error not created' }
      end
    end
  end
  
  def destroy
    @t_file = TFile.find_by_id(params[:id])
    @classroom = Classroom.find_by_id(@t_file.classroom_id)
    @t_file.destroy
    respond_to do |format|
      if @t_file.save
        format.html { redirect_to @classroom, notice: 'File was successfully deleted.' }
        format.json { head :no_content }
      end
    end
  end
  
  private
  def tf_params
      params.require(:t_file).permit(:classroom_id, :name, :file)
  end
  
end
