require 'spec_helper'

describe Crawler::Page do
  subject(:page) { described_class.new("http://www.google.com") }

  describe "#initialize" do
    before do
      @response_double = double
      @faraday_double = instance_double(Faraday::Connection)
      allow(Faraday).to receive(:new).and_return(@faraday_double)
    end

    it "retrieves the page content" do
      allow(@faraday_double).to receive(:get).and_return(@response_double)
      allow(@response_double).to receive(:body).and_return("body")

      expect(page.content).to eq "body"
    end
  end
end
