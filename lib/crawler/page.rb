module Crawler
  class Page
    attr_reader :content

    def initialize(location)
      @content = get_page(location)
    end

    private

    def get_page(location)
      base, path = decompose_location(location)

      agent(base).get(path).body
    end

    def decompose_location(location)
      parts = location.split('/')

      base = "#{parts[0]}//#{parts[2]}"
      path = parts[3..-1].join('/')

      [base, path]
    end

    def agent(uri_base)
      Faraday.new(url: uri_base) do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
