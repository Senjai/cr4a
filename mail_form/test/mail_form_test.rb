require 'test_helper'
require 'fixtures/sample_mail'

class MailFormTest < ActiveSupport::TestCase
  test "sample mail has name and email as attributes" do
    sample = SampleMail.new
    sample.name = "User"
    assert_equal "User", sample.name
    sample.email = "test@test.com"
    assert_equal "test@test.com", sample.email

    sample.clear_name
    sample.clear_email
    assert_nil sample.clear_name
    assert_nil sample.clear_email
  end

  test "sample mail can ask if an attribute is present or not" do
    sample = SampleMail.new
    assert !sample.name?

    sample.name = "User"
    assert sample.name?

    sample.email = ""
    assert !sample.email?
  end
end
