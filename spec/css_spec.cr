require "./spec_helper"

describe Hq::Css do
  nodes = Hq::Css.parse <<-EOF
    <!doctype html>
    <html>
      <head><meta charset="utf-8"><title>menu</title></head>
      <body>
        <nav>
          links
          <ul class="menu">
            <li><a href="https://github.com/crystal-lang/crystal" class="official">crystal</a></li>
            <li><a href="https://github.com/maiha/hq.cr">hq.cr</a></li>
          </ul>
        </nav>
      </body>
    </html>
    EOF

  describe "#css" do
    it "should return empty nodes when not found" do
      nodes.css("xxx").size.should eq(0)
    end

    it "should search nodes of given tag name" do
      nodes.css("nav").size.should eq(1)
      nodes.css("li").map(&.name).uniq.should eq(["li"])
      nodes.css("li").map(&.text).should eq(["crystal", "hq.cr"])
    end

    it "should parse partial html" do
      nodes = Hq::Css.parse <<-EOF
        <ul>
          <li>foo</li>
          <li>bar</li>
        </ul>
        EOF

      nodes.css("li").map(&.text).should eq(["foo", "bar"])
    end
  end
end
