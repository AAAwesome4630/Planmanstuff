class Assignment < ActiveRecord::Base
    
    belongs_to :classroom
    
        def start_time
        self.due_date ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship
    end
    
end
