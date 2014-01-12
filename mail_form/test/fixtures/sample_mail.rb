class SampleMail < MailForm::Base
  attributes :name, :email

  def headers
    { to: "recepient@example.com", from: self.email }
  end
end
