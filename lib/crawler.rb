require 'faraday'
require 'faraday_middleware'
require 'nokogiri'

require_relative 'crawler/config.rb'
require_relative 'crawler/page.rb'
require_relative 'crawler/page_processor.rb'
require_relative 'crawler/href_normalizer.rb'
require_relative 'crawler/map.rb'
