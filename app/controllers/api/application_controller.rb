module Api
  class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
    protect_from_forgery with: :null_session
    
     attr_reader :current_student
  
    protected
    def authenticate_student_request!
      unless student_id_in_token?
        render json: { errors: ['Student Not Authenticated'] }, status: :unauthorized
        return
      end
      @current_student = Student.find(student_auth_token[:student_id])
    rescue JWT::VerificationError, JWT::DecodeError
      render json: { errors: ['Student Not Authenticated'] }, status: :unauthorized
    end
  
    private
    def http_student_token
      if request.headers['sAuthorization'].present?
        @http_token ||= if request.headers['sAuthorization'].present?
          request.headers['sAuthorization'].split(' ').last
        end
      end
    end
  
    def student_auth_token
      @auth_token ||= JsonWebToken.decode(http_student_token)
    end
  
    def student_id_in_token?
      http_student_token && student_auth_token && student_auth_token[:student_id].to_i
    end
    
     attr_reader :current_teacher
  
    protected
    def authenticate_teacher_request!
      unless teacher_id_in_token?
        render json: { errors: ['Teacher Not Authenticated'] }, status: :unauthorized
        return
      end
      @current_teacher = Teacher.find(teacher_auth_token[:teacher_id])
    rescue JWT::VerificationError, JWT::DecodeError
      render json: { errors: ['Teacher Not Authenticated'] }, status: :unauthorized
    end
  
    private
    def http_teacher_token
      if request.headers['tAuthorization'].present?
        @http_token ||= if request.headers['tAuthorization'].present?
          request.headers['tAuthorization'].split(' ').last
        end
      end
    end
  
    def teacher_auth_token
      @auth_token ||= JsonWebToken.decode(http_teacher_token)
    end
  
    def teacher_id_in_token?
      http_teacher_token && teacher_auth_token && teacher_auth_token[:teacher_id].to_i
    end
    
    
    #helper methods continued
    
    def student_assignmentstests(student_id)
      @assignments = Assignment.all
      @tests = Test.all
      
      
      @srelationships = ScRelationship.all.where("student_id = ?", student_id )
      
      
      sclassrooms = Array.new
      
      for @relationship in @srelationships do
        sclassrooms.push(@relationship.classroom_id)
      end
      
      
      @sassignments = Assignment.where("classroom_id IN (?)", sclassrooms)
      @stests = Test.where("classroom_id IN (?)", sclassrooms)
    end
  end
end
  
  
  

