module PinchHitter::Message
  class Html < ContentType

    def self.valid_message?(string)
      string =~ /\A(\s|<!doctype[^>]*>)*<html\b/i
    end

    def self.format_message(message, overrides={})
      raise "Overrides are not supported for HTML responses" unless overrides.empty?
      message
    end

    def self.header_string
      "text/html"
    end

  end
end
