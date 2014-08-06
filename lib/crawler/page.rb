module Crawler
  class Page
    attr_reader :content, :base, :path, :links, :assets

    def initialize(location)
      @content = get_page(location)
    end

    def links
      @links ||= processor.links_in(@content).map do |href|
        url_for href
      end
    end

    def assets
      @assets ||= processor.assets_in(@content)
    end

    private

    def get_page(location)
      decompose_location(location)

      agent(base).get(path).body
    end

    def decompose_location(location)
      parts = location.split('/')

      @base = "#{parts[0]}//#{parts[2]}"
      @path = parts[3..-1].join('/')
    end

    def agent(uri_base = nil)
      @agent ||= Faraday.new(url: uri_base) do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end

    def processor
      @processor ||= Processor.new(base)
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

    def url_from_relative(href)
      "#{base}/#{path_without_file}/#{href}"
    end

    def path_without_file
      if path.split('/').last.match(/\./)
        path.split('/')[0..-2].join('/')
      else
        path
      end
    end
  end
end
