module Crawler
  module Emitters
    def self.new(format)
      self.const_get(constantize format).new
    end

    private

    def self.constantize(format)
      format.to_s.split('_').map{ |part| part.capitalize }.join('')
    end
  end
end
