class Student::ParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:first_name, :last_name, :join_token, :school_name, :s_join_token ])
    permit(:sign_in, keys: [:join_token, :s_join_token ])
    permit(:account_update, keys:[:first_name, :last_name, :school_name])
  end
end