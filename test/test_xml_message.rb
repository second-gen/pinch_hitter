ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'

class TestXmlMessage < MiniTest::Test

  def xml_message
%Q{<?xml version='1.0' encoding='UTF-8'?>
<wrapper>
  <Body xmlns:ns='http://www.abc.org/OTA/2003/05'>
    <node>text</node>
    <withattrib attrib='value'/>
    <ns:testnode>text</ns:testnode>
  </Body>
</wrapper>
}
  end

  def test_message_no_overrides
    assert_equal xml_message, PinchHitter::Message::Xml.format_message(xml_message)
  end

  def test_message_tag_override
    xml = PinchHitter::Message::Xml.format_message(xml_message, {"node" => "newtext"})
    assert xml.include? "<node>newtext</node>"
  end

  def test_message_tag_override_attrib
    xml = PinchHitter::Message::Xml.format_message(xml_message,
        {"withattrib@attrib" => "BetterValue"})
    assert xml.include? "<withattrib attrib='BetterValue'"
  end

  def test_message_tag_override_with_namespace
    xml = PinchHitter::Message::Xml.format_message(xml_message, {"ns:testnode" => 'newValue'})
    assert xml.include? "<ns:testnode>newValue</ns:testnode>"
  end
end
