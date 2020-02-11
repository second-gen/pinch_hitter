require 'set'

module PinchHitter::Message
  class ContentType

    def self.determine_content_type_by_message(message)
      content_type = registered_content_types.find do |type|
        type.valid_message? message
      end
      content_type.header_string
    end

    def self.determine_content_type_by_extension(extension)
      registered_content_types.find do |type|
        type.extension == extension
      end
    end

    def self.registered_content_types
      @registered_content_types ||= Set.new
    end

    def self.inherited(subclass)
      registered_content_types << subclass
    end

    def self.valid_message?(message)
      raise NotImplementedError
    end

    def self.format_message(message, overrides={})
      raise NotImplementedError
    end

    def self.header_string
      raise NotImplementedError
    end

    def self.extension
      name[/(?<=::)[^:]+$/].downcase
    end

  end
end

require 'pinch_hitter/message/json'
require 'pinch_hitter/message/xml'
require 'pinch_hitter/message/plain_text'
