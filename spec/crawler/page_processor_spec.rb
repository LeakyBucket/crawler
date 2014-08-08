require 'spec_helper'

describe Crawler::PageProcessor do
  subject(:processor) { described_class.new('http://test.com') }
  let(:page) { File.read('./spec/fixtures/page.html') }

  let(:assets) do
    [
      'http://www.google.com/logo.jpg',
      'layout.css',
      'link_stuff'
    ]
  end

  describe "#assets_in" do
    it "returns a list of all static assets in the page" do
      expect(processor.assets_in page).to eq assets
    end
  end

  describe "#links_in" do
    it "returns a list of all links in the page" do
      links = processor.links_in page

      expect(links.length).to eq 3
    end
  end
end
