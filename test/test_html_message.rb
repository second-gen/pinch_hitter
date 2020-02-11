ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'

class TestHtmlMessage < MiniTest::Test

  def html_message
%Q{<!doctype html>
<html>
  <head></head>
  <body>
    <h1>Hello there</h1>
    <p>How are you?</p>
  </body>
</html>}
  end

  def test_message_no_overrides
    assert_equal html_message, PinchHitter::Message::Html.format_message(html_message)
  end

  def test_message_with_empty_overrides_is_fine
    assert_equal html_message, PinchHitter::Message::Html.format_message(html_message, {})
  end

  def test_message_with_overrides_raises_an_error
    error = assert_raises RuntimeError do
      PinchHitter::Message::Html.format_message(html_message, { "h1" => 'WhatsUpDoc?' })
    end

    assert_equal error.message, "Overrides are not supported for HTML responses"
  end
end
