class AnnouncementsController < ApplicationController
  before_filter :authenticate_teacher!


  def edit
    @announcement = Announcement.find_by_id(params[:id])
  end
  
  def update
     @announcement = Announcement.find_by_id(params[:id])
     @classroom = Classroom.find_by_id(@announcement.classroom_id)
    respond_to do |format|
      if @assginment.update!(announcement_params)
        format.html { redirect_to @classroom, notice: 'Announcement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @announcement.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def create
    @announcement = Announcement.new(tf_params)
    respond_to do |format|
      if @announcement.save
        format.html { redirect_to "", notice: 'Announcement was successfully created.' }
      else
        format.html { redirect_to "", notice: 'error not created' }
      end
    end
  end
  
  
  def destroy
    @announcement = Announcement.find_by_id(params[:id])
    @classroom = Classroom.find_by_id(@announcement.classroom_id)
    @assigment.destroy
    respond_to do |format|
      if @announcement.save
        format.html { redirect_to @classroom, notice: 'Announcement was successfully deleted.' }
        format.json { head :no_content }
      end
    end
  end
  private
   
  def tf_params
      params.require(:announcement).permit(:classroom_id, :header, :content)
  end
  
end
