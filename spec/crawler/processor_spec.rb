require 'spec_helper'

describe Crawler::Processor do
  subject(:processor) { described_class.new('http://test.com') }
  let(:page) { File.read('./spec/fixtures/page.html') }
  let(:links) do
    [
      'http://www.google.com',
      'http://www.peakhosting.com',
      'http://test.com/absolute/path.html'
    ]
  end
  let(:assets) do
    [
      'http://www.google.com/logo.jpg',
      'layout.css'
    ]
  end

  describe "#assets_in" do
    it "returns a list of all static assets in the page" do
      expect(processor.assets_in page).to eq assets
    end
  end

  describe "#links_in" do
    it "returns a list of all links in the page" do
      expect(processor.links_in page).to eq links
    end
  end
end
