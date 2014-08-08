require 'spec_helper'

describe Crawler::Map do
  subject(:site_map) { described_class.new }
  let(:url) { 'https://www.google.com' }

  let(:links) do
    [
      'http://www.google.com/fake/path',
      'http://www.google.com/another/fake/path'
    ]
  end

  let(:assets) do
    [
      'styles.css',
      'behaviors.js',
      'link_stuff'
    ]
  end

  let(:page) do
    page = double

    allow(page).to receive(:location).and_return(url)
    allow(page).to receive(:links).and_return(links)
    allow(page).to receive(:assets).and_return(assets)

    page
  end

  describe "#add" do
    before do
      site_map.add page
    end

    it "adds the pages links" do
      page_record = site_map.site[url]

      expect(page_record[:links].to_a).to eq links
    end

    it "adds the assets to the static_assets collection" do
      expect(site_map.static_assets).to include 'styles.css', 'behaviors.js'
    end

    it "adds the assets indexes to the page entry" do
      page_record = site_map.site[url]

      expect(page_record[:assets]).to include 0, 1
    end
  end
end
