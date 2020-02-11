ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'

class TestPlainTextMessage < MiniTest::Test

  def text_message
%Q{This is a plain text document.
It has two lines.}
  end

  def test_message_no_overrides
    assert_equal text_message, PinchHitter::Message::PlainText.format_message(text_message)
  end

  def test_message_with_empty_overrides_is_fine
    assert_equal text_message, PinchHitter::Message::PlainText.format_message(text_message, {})
  end

  def test_message_with_overrides_raises_an_error
    error = assert_raises RuntimeError do
      PinchHitter::Message::PlainText.format_message(text_message, { "item" => 'WhatsUpDoc?' })
    end

    assert_equal error.message, "Overrides are not supported for Plain Text responses"
  end
end
