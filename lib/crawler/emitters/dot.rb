module Crawler
  module Emitters
    class Dot
      ASSET_PREAMBLE = "digraph StaticAssets {\nnode [shape=record];\nstruct1 [shape=record,label=\"{ "
      ASSET_END = "}\"];\n}"

      def emit(map, path)
        @dot_file = File.new(path, 'w')

        add_pages(map.site)
        add_assets(map.static_assets)

        @dot_file.close
      end

      private

      def add_pages(links)
        @dot_file.puts 'digraph SiteMap {'

        urls = links.keys

        until urls.empty?
          add_page(urls.pop, links)
        end

        @dot_file.puts '}'
      end

      def add_page(page, links)
        links[page][:links].each do |link|
          @dot_file.puts "\"#{page}\" -> \"#{link}\";"
        end
      end

      def add_assets(assets)
        assets = assets.to_a
        struct_parts = []

        assets.each_with_index do |asset, index|
          struct_parts << "{#{index} | \\\"#{asset}\\\"}"
        end

        @dot_file.puts ASSET_PREAMBLE + struct_parts.join(' | ') + ASSET_END
      end
    end
  end
end
