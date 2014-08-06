module Crawler
  class Page
    attr_reader :content, :location, :links, :assets, :normalizer

    def initialize(location)
      @location = location
      @normalizer = HrefNormalizer.new(location)
      @content = get_page
    end

    def links
      @links ||= processor.links_in(@content).map do |href|
        normalizer.url_for href
      end
    end

    def assets
      @assets ||= processor.assets_in(@content)
    end

    private

    def get_page
      agent(base).get(path).body
    end

    def agent(uri_base = nil)
      @agent ||= Faraday.new(url: uri_base) do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end

    def processor
      @processor ||= Processor.new(base)
    end

    def base
      normalizer.base
    end

    def path
      normalizer.path
    end
  end
end
