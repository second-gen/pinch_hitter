module PinchHitter::Message
  class Json < ContentType

    def self.format_message(message, overrides={})
      return message if overrides.empty?
      doc = JSON.parse(message)
      overrides.each do |key, value|
        hash = find_nested_hash(doc, key)
        if has_key(hash, key)
          hash[key] = value
        end
      end
      doc.to_json
    end

    def self.valid_message?(string)
      JSON.parse string
      return true
    rescue
      return false
    end

    def self.header_string
      "application/json"
    end

    private
    def self.find_nested_hash(parent, key)
      return parent if has_key(parent, key)
      return nil unless parent.respond_to? :each

      found = nil
      parent.find do |parent_key, child|
        found = find_nested_hash(child, key)
      end
      found
    end

    def self.has_key(hash, key)
      hash.respond_to?(:key?) && hash.key?(key)
    end

  end
end
