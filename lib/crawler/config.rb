module Crawler
  class Config
    attr_reader :boundary, :domain

    def initialize(domain, subs = false)
      @domain = domain
      set_boundary(subs)
    end

    private

    def set_boundary(allow_subs)
      if allow_subs
        @boundary = /^([\w-]*\.)*#{domain}$/
      else
        @boundary = /^#{domain}$/
      end
    end
  end
end
