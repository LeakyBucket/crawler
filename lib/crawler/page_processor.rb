module Crawler
  class PageProcessor
    attr_reader :base

    def initialize(base)
      @base = base
    end

    def links_in(content)
      doc = Nokogiri::XML content

      hrefs_from doc.xpath('//a')
    end

    def assets_in(content)
      doc = Nokogiri::XML content
      assets = names_for(doc.xpath('//img') + doc.xpath('//script'))

      assets.compact
    end

    private

    def hrefs_from(anchor_collection)
      anchor_collection.map do |anchor|
        anchor.attributes['href'].value
      end
    end

    def names_for(asset_collection)
      asset_collection.map do |asset|
        if asset.attributes.has_key?('src')
          asset.attributes['src'].value
        else
          next
        end
      end
    end
  end
end
