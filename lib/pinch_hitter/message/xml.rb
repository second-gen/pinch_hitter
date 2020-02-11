require 'rexml/document'
require 'rexml/xpath'

module PinchHitter::Message
  class Xml < ContentType

    def self.valid_message?(string)
      string =~ /\A\s*<(\?xml|soap)/i
    end

    def self.format_message(message, overrides={})
      xml = REXML::Document.new message
      overrides.each do |key, text|
        replace_xml(xml, key, text)
      end
      xml.to_s
    end

    def self.header_string
      "text/xml"
    end

    private
    def self.replace_xml(xml, key, text)
      parts = key.split('@')
      tag = find_node xml, parts.first

      if parts.length == 1
        #match text node
        tag.text = text
      else
        #match attribute
        tag.attributes[parts.last] = text
      end
    end

    def self.find_node(xml, tag)
      REXML::XPath.first(xml, "//#{tag}")
    end
  end
end
