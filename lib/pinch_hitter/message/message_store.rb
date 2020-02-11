require 'pinch_hitter/message/content_type'

module PinchHitter::Message
  class MessageStore

    attr_accessor :message_directory

    def initialize(message_directory)
      @message_directory = message_directory
    end

    def load(file, overrides={})
      filename = find_filename file
      file_extension = filename[/(?<=\.)[^.]+$/]
      fail "Filename must have an extension to indicate type of response (#{filename})" if file_extension.nil?
      content_type = ContentType.determine_content_type_by_extension file_extension
      fail "Unsupported file type #{file_extension.inspect}. Supported types are: #{ContentType.registered_content_types.map(&:extension)}" if content_type.nil?
      content_type.format_message File.read(filename), overrides
    end

    def find_filename(file)
      filename = Dir["#{message_directory}/#{file}*"].first
      unless filename
        fail "Could not find message for '#{file}' in '#{File.expand_path(File.dirname(message_directory))}'"
      end
      filename
    end

  end
end
