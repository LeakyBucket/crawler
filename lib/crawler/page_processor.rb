module Crawler
  class PageProcessor
    attr_reader :base

    def initialize(base)
      @base = base
    end

    def links_in(content)
      doc = Nokogiri::HTML content

      hrefs_from(doc.xpath('//a')).compact.delete_if { |href| href.empty? }
    end

    def assets_in(content)
      doc = Nokogiri::HTML content
      assets = names_for(doc.xpath('//img') + doc.xpath('//script') + doc.xpath('//link'))

      assets.compact
    end

    private

    def hrefs_from(anchor_collection)
      anchor_collection.map do |anchor|
        if anchor.attributes.has_key? 'href'
          anchor.attributes['href'].value
        end
      end
    end

    def names_for(asset_collection)
      asset_collection.map do |asset|
        if asset.attributes.has_key? 'src'
          asset.attributes['src'].value
        elsif asset.attributes.has_key? 'href'
          asset.attributes['href'].value
        end
      end
    end
  end
end
