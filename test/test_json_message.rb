ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'

class TestJsonMessage < MiniTest::Test

  def json_message
%Q{{"menu": {
  "id": "file",
  "value": "File",
  "popup": {
    "menuitem": "OpenDoc()"
  },
  "trigger" : {
    "action" : "confirm"
  }
}}
}
  end

  def test_message_no_overrides
    assert_equal json_message, PinchHitter::Message::Json.format_message(json_message)
  end

  def test_message_with_overrides
    json = PinchHitter::Message::Json.format_message(json_message, { "menuitem" => 'WhatsUpDoc?' })
    assert json.include? "WhatsUpDoc?"
  end
end
