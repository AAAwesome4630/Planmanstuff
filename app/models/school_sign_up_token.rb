class SchoolSignUpToken < ActiveRecord::Base
    
   before_create :generate_token
   
   def create
      @school_sign_up_token = SchoolSignUpToken.new(token_params)
      respond_to do |format|
      if @school_sign_up_token.save
        format.html { redirect_to "", notice: 'Token Created was successfully created.' }
      else
        format.html { redirect_to "", notice: 'error not created' }
      end
    end
   
   end
   

   def generate_token
      self.token = SecureRandom.base64(15).tr('+/=lIO0', 'abc123')
   end
    
    private 
    
    def token_params
       params.require(:school_sign_up_token).permit(:token, :expires_at)
    end
    
    
       
    
end
