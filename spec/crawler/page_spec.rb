require 'spec_helper'

describe Crawler::Page do
  subject(:page) { described_class.new("http://www.google.com/pages") }

  let(:hrefs) do
    [
      'http://www.google.com/page.html',
      '/one/level/down',
      'one/level/from/here'
    ]
  end

  before do
    @response_double = double
    @faraday_double = instance_double(Faraday::Connection)
    allow(Faraday).to receive(:new).and_return(@faraday_double)
  end

  describe "#initialize" do
    it "retrieves the page content" do
      allow(@faraday_double).to receive(:get).and_return(@response_double)
      allow(@response_double).to receive(:body).and_return("body")

      expect(page.content).to eq "body"
    end
  end

  describe "#links" do
    before do
      processor = instance_double(Crawler::Processor)
      allow(processor).to receive(:links_in).and_return(hrefs)
      allow(Crawler::Processor).to receive(:new).and_return(processor)
      allow(@faraday_double).to receive(:get).and_return(@response_double)
      allow(@response_double).to receive(:body).and_return("body")
    end

    it "normalizes absolute hrefs" do
      expect(page.links).to include 'http://www.google.com/one/level/down'
    end

    context "relative hrefs" do
      it "normalizes relative hrefs when there is no file" do
        expect(page.links).to include 'http://www.google.com/pages/one/level/from/here'
      end

      it "normalizes relative hrefs when there is a file" do
        page = described_class.new('http://www.google.com/pages/pages.html')

        expect(page.links).to include 'http://www.google.com/pages/one/level/from/here'
      end
    end
  end
end
