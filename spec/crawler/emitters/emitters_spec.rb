require 'spec_helper'

describe Crawler::Emitters do
  subject(:emitter) { Crawler::Emitters }

  describe "#new" do
    it "returns an instance of the specified emitter" do
      expect(emitter.new :dot).to be_kind_of Crawler::Emitters::Dot
    end

    it "raises UnknownFormat if given a bad format symbol" do
      expect { emitter.new :bogus }.to raise_exception(Crawler::Emitters::UnknownFormat)
    end
  end
end
