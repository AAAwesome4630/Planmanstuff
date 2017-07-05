class StudentsController < Devise::RegistrationsController
    
    autocomplete :school, :name
    
end
