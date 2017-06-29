class AuthenticationController < Api::ApplicationController
    
  def authenticate_student
    student = Student.find_for_database_authentication(email: params[:email])
    if student.valid_password?(params[:password])
      render json: spayload(student)
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end
  
  def authenticate_teacher
    teacher = Teacher.find_for_database_authentication(email: params[:email])
    if teacher.valid_password?(params[:password])
      render json: tpayload(teacher)
    else
      render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    end
  end

  private

  def spayload(student)
    return nil unless student and student.id
    {
      auth_token: JsonWebToken.encode({student_id: student.id}),
      student: {id: student.id, email: student.email}
    }
  end
  
  private
  
  def tpayload(teacher)
    return nil unless teacher and teacher.id
    {
      auth_token: JsonWebToken.encode({teacher_id: teacher.id}),
      teacher: {id: teacher.id, email: teacher.email}
    }
  end


end
