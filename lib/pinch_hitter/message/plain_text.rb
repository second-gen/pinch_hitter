module PinchHitter::Message
  class PlainText < ContentType

    def self.valid_message?(message)
      true
    end

    def self.format_message(message, overrides={})
      raise "Overrides are not supported for Plain Text responses" unless overrides.empty?
      message
    end

    def self.header_string
      "text/plain"
    end

    def self.extension
      "txt"
    end

  end
end
