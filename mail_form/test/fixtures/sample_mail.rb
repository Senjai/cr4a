class SampleMail < MailForm::Base
  attributes :name, :email, :nickname

  validates :nickname, absence: true

  def headers
    { to: "recepient@example.com", from: self.email }
  end
end
