class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def current_ability
    if administrator_signed_in?
      @current_ability ||= Ability.new(current_administrator)
    elsif student_signed_in?
      @current_ability ||= Ability.new(current_student)
    else
       @current_ability ||= Ability.new(current_teacher)
     end
  end


    protected
=begin    def devise_parameter_sanitizer
      if resource_class == Student
        Student::ParameterSanitizer.new(Student, :student, params)
      elsif resource_class == Teacher
        Teacher::ParameterSanitizer.new(Teacher, :teacher, params)
      elsif resource_class == Administrator
        Administrator::ParameterSanitizer.new(Administrator, :administrator, params)
      end
        
    end
=end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :remember_me,:first_name, :last_name, :join_token, :school_name, :s_join_token,:title, :avatar, :avatar_cache ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password, :join_token, :s_join_token ])
    devise_parameter_sanitizer.permit(:account_update, keys:[:email, :password, :password_confirmation, :current_password,:first_name, :last_name, :school_name, :title, :avatar, :avatar_cache, :remove_avatar])
  end
  
  private
=begin
def after_sign_in_path_for(resource)
  blacklist = [new_student_session_path, new_student_registration_path] # etc...
  last_url = session["student_return_to"]
  if blacklist.include?(last_url)
    root_path
  else
    last_url
  end
end
=end

end

  
  
  

