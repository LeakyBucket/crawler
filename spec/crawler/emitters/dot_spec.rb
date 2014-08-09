require 'spec_helper'

describe Crawler::Emitters::Dot do
  subject(:dot_emitter) { described_class.new }
  let(:dot_file) { './spec/fixtures/test.dot' }
  let(:map) { Crawler::Map.new }
  let(:location) { 'http://bob.com' }
  let(:links) { ['http://bob.com/taco'] }
  let(:assets) { ['http://bob.com/style.css'] }

  let(:page) do
    page = double
    allow(page).to receive(:location).and_return(location)
    allow(page).to receive(:links).and_return(links)
    allow(page).to receive(:assets).and_return(assets)

    page
  end

  describe "#emit" do
    after do
      File.unlink dot_file
    end

    it "writes a dot file to the specified file" do
      map.add page
      dot_emitter.emit(map, dot_file)

      expect(File.exists? dot_file).to be true
    end

    it "writes the links to the dotfile" do
      map.add page
      dot_emitter.emit(map, dot_file)

      expect(File.read dot_file).to include "\"#{location}\" -> \"#{links[0]}\";"
    end

    it "writes the assets to the dotfile" do
      map.add page
      dot_emitter.emit(map, dot_file)

      expect(File.read dot_file).to include "{0 | \\\"#{assets[0]}\\\"}"
    end
  end
end
