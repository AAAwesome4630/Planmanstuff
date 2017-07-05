class SchoolsController < ApplicationController
  def index
  

      @schools = School.search(params[:term])

      render json: @schools.map(&:name)
  end
  
  def show
  end
end