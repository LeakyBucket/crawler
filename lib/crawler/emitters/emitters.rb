module Crawler
  module Emitters
    def self.new(format)
      emitter = self.const_get(constantize format)

      emitter.new
    rescue NameError => e
      raise UnknownFormat, "Failed to find an emitter for the #{format} format"
    end

    private

    def self.constantize(format)
      format.to_s.split('_').map{ |part| part.capitalize }.join('')
    end

    class UnknownFormat < StandardError; end
  end
end
