module Api
    class SpagesController < ApplicationController
        before_filter :authenticate_student_request!
        
    def index
      
      @assignments = Assignment.all
      @tests = Test.all
      
      
      @srelationships = ScRelationship.all.where("student_id = ?", current_student.id )
      
      
      sclassrooms = Array.new
      
      for @relationship in @srelationships do
        sclassrooms.push(@relationship.classroom_id)
      end
      
      
      @sassignments = Assignment.where("classroom_id IN (?)", sclassrooms)
      @stests = Test.where("classroom_id IN (?)", sclassrooms)
      respond_to do |format|
        format.json  { render :json => {:assignements => @assignments, 
                                        :tests => @tests }}
      end
    end
    
    end
end
