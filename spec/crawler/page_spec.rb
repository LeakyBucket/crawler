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

    it "returns all the links in the page" do
      links = page.links

      expect(links.length).to eq 3
    end
  end
end
