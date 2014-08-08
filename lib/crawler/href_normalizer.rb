require 'uri'

class String
  def to_ascii
    self.encode('ascii', invalid: :replace, undef: :replace, replace: '')
  end
end

module Crawler
  class HrefNormalizer
    attr_reader :location, :base, :path

    def initialize(location)
      @location = URI.parse location
    end

    def url_for(href)
      URI.join(location, clean(href)).to_s
    rescue => e
      nil # because it's easier to compact later
    end

    def base
      "#{location.scheme}://#{location.host}"
    end

    def path
      location.path
    end

    private

    def clean(href)
      strip_fragment strip_query(href.to_ascii)
    end

    def strip_query(href)
      href.split('?').first || ''
    end

    def strip_fragment(href)
      href.split('#').first || ''
    end
  end
end
