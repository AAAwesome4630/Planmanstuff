class FormsController < ApplicationController
    
    def newclassroom
        
        @classroom = Classroom.new
        
    end
end
