class Administrator::ParameterSanitizer < Devise::ParameterSanitizer
  def initialize(*)
    super
    permit(:sign_up, keys: [:first_name, :last_name, :title, :join_token, :school_name ])
    permit(:sign_in, keys: [:join_token ])
    permit(:account_update,keys:[:first_name, :last_name, :school_id, :title])
  end
end