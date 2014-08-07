module Crawler
  class HrefNormalizer
    attr_reader :location, :base, :path

    def initialize(location)
      @location = location

      decompose_location
    end

    def url_for(href)
      case href
      when /^http/
        href
      when /^\//
        base + href
      else
        url_from_relative href
      end
    end

    private

    def decompose_location
      parts = location.split('/')

      @base = "#{parts[0]}//#{parts[2]}"
      @path = parts[3..-1].join('/')
    end

    def url_from_relative(href)
      "#{base}#{path_without_file}#{href}"
    end

    def path_without_file
      if path.empty?
        '/'
      elsif path.split('/').last.match(/\./)
        '/' + path.split('/')[0..-2].join('/') + '/'
      else
        "/#{path}/"
      end
    end
  end
end
