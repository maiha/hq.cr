# hq.cr [![Build Status](https://travis-ci.org/maiha/hq.cr.svg?branch=master)](https://travis-ci.org/maiha/hq.cr)

a simple wrapper for crystal-xml
- gateway pattern : suppress errors until values are referenced
- handy accessors : provide useful extractors and conversions

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  hq:
    github: maiha/hq.cr
```

## Usage

```crystal
require "hq"

node = Hq.parse("<html><body><div>82 users</div></body></html>")
node.xpath("/html/body/div").text # => "82 users"
node.xpath("/html/body/div").int  # => 82
node.xpath("/html/body/nav").int? # => nil
node.xpath("/html/body").path     # => "/html/body"
node.xpath("/html/div").text      # raise Hq::NotFound.new(key: "/html/div")
```

### css (WIP)

```crystal
nodes = Hq::Css.parse <<-EOF
  <ul>
    <li>foo</li>
    <li>bar</li>
  </ul>
  EOF

nodes.css("li").map(&.text)  # => ["foo", "bar"]
```

## Roadmap

#### 0.2.0

- [x] support `css(tag)`

#### 0.3.0

- [ ] support `css(tag_with_class)` 
- [ ] support `Css::Node#attributes`

#### 0.4.0

- [ ] support `Hq.mapping` like `jq.cr`

## Contributing

1. Fork it ( https://github.com/maiha/hq.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [maiha](https://github.com/maiha) maiha - creator, maintainer
