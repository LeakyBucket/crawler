module Crawler
  class Config
    attr_reader :boundary

    def initialize(domain, subs = false)
      set_boundary(domain, subs)
    end

    private

    def set_boundary(domain, subs)
      if subs
        @boundary = /^([\w-]*\.)*#{domain}$/
      else
        @boundary = /^#{domain}$/
      end
    end
  end
end
