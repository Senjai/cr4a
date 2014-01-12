require 'test_helper'
require 'fixtures/sample_mail'

class MailFormTest < ActiveSupport::TestCase
  test "sample mail has name and email as attributes" do
    sample = SampleMail.new
    sample.name = "User"
    assert_equal "User", sample.name
    sample.email = "test@test.com"
    assert_equal "test@test.com", sample.email
  end
end
