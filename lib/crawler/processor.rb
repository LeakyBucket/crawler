module Crawler
  class Processor
    attr_reader :base

    def initialize(base)
      @base = base
    end

    def links_in(content)
      doc = Nokogiri::XML content

      normalize_anchors doc.xpath('//a')
    end

    def assets_in(content)
      doc = Nokogiri::XML content
      assets = names_for(doc.xpath('//img') + doc.xpath('//script'))

      assets.compact
    end

    private

    def normalize_anchors(anchor_collection)
      anchor_collection.map do |anchor|
        as_url anchor.attributes['href'].value
      end
    end

    def as_url(href)
      href.match(/^http[s]?:\/\//) ? href : "#{base}#{href}"
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
