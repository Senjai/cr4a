require 'test_helper'

class RenderingTest < ActionDispatch::IntegrationTest
  test ".rb template handler" do
    get '/handlers/rb_handler'

    expected = "This is my first <b>template handler</b>!"

    assert_match expected, response.body
  end
end
