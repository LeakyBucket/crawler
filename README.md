# Crawler

A simple ruby library for crawling web domains.  

This is more of a best effort implementation.

## Usage

This library comes with a small example in `bin`.
It is a single class which utilizes the library to crawl a
single domain.

If you wish to roll your own implementation there are a
few things you will need to do.

### Configuration

`Crawler::Config` this object handles boundry configuration.
The initializer accepts two arguments: the domain and a flag
indicating whether subdomains are to be mapped or not.

```ruby
  config = Crawler::Config.new 'www.example.com', false
```

### Pages

`Crawler::Page` represents a page on the site.  It accepts a
location and provides two accessors `content` and `response_code`
there are also methods for retrieving all links on the page
`links` and all assets on the page `assets`

```ruby
  page = Crawler::Page.new 'http://www.example.com'

  page.content
  # => "<!doctype html><html>..."

  page.response_code
  # => 200

  page.links
  # => #<Set: {"http://www.iana.org/domains/example"}>

  page.assets
  # => []
```

### Results

`Crawler::Map` this is the Site Map.  It consists of a reader
for the `site`, a reader for the `static_assets` and `add` which
adds a page to the Site Map.

The `map` is a hash of `URL`s each with `:links` and
`:assets`.  The links collection holds all the `URL`s
linked to from that page and the assets collection holds
references to the `static_assets` collection indicating
the static assets found on that page.

```ruby
  map = Crawler::Map.new

  map.add page
  # => {:links=>#<Set: {"http://www.iana.org/domains/example"}>, :assets=>[]}

  map.site
  # => "http://www.example.com"=>
  #      {:links=>#<Set: {"http://www.iana.org/domains/example"}>, :assets=>[]}}
```

`Crawler::Emitters` handles output of Site Map.
`Crawler::Emitters.new` takes one argument.  That is a symbol
representing the desired output format.  Currently the only
format provided by default is `DOT`.

```ruby
  dot = Crawler::Emitters.new :dot

  dot.emit map, './site_map.dot'
```

__Note__:  
You can add new `Emitters` simply by adding a new class to
the `Crawler::Emitters` namespace.  After doing that you can
use it by passing `Crawler::Emitters.new` the class name as a
snake cased symbol.
