module Crawler
  class Map
    attr_reader :site, :static_assets

    def initialize
      @site = {}
      @static_assets = Set.new
    end

    def add(page)
      site[page.location] = {
        links: Set.new(page.links),
        assets: assets_index_for(page)
      }
    end

    private

    def assets_index_for(page)
      page.assets.map do |asset|
        static_assets.add asset
        static_assets.find_index asset
      end
    end
  end
end
