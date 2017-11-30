class Contact < MailForm::Base

  attribute :school_name,      :validate => true
  attribute :person_name
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :address#,   :validate => true
  attribute :message
  attribute :file,      :attachment => true

  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "School Contact Form",
      :to => "adith85086@gmail.com",
      :from => %("#{person_name}" <#{email}>)
    }
  end
end