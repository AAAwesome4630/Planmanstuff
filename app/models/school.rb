class School < ActiveRecord::Base
    
    has_many :administrators
    
    serialize :administrators, Array
    serialize :teachers, Array
    serialize :students, Array
end
