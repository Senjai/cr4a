require 'test_helper'
require 'fixtures/sample_mail'

class MailFormTest < ActiveSupport::TestCase
  setup do
    ActionMailer::Base.deliveries.clear
  end

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

  test "delivers an email with attributes" do
    sample = SampleMail.new

    # Simulate form data
    sample.email = "user@example.com"
    sample.deliver

    assert_equal 1, ActionMailer::Base.deliveries.size
    mail = ActionMailer::Base.deliveries.last

    assert_equal ["user@example.com"], mail.from
    assert_match "Email: user@example.com", mail.body.encoded
  end

  test "validates the absence of a nickname" do
    sample = SampleMail.new(nickname: "Spam")
    assert !sample.valid?
    assert_equal ["is invalid"], sample.errors[:nickname]
  end

  test "provides before and after deliver hooks" do
    sample = SampleMail.new(email: "user@example.com")
    sample.deliver
    assert_equal [:before, :after], sample.evaluated_callbacks
  end
end
