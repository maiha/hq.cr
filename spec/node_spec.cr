require "./spec_helper"

describe Hq::Node do
  node = Hq.parse(fixture_menu_html)

  describe "#node" do
    it "should return a native node" do
      node.node.should be_a(XML::Node)
    end
  end

  describe "#xpath" do
    it "should return a new node" do
      n = node.xpath("/html/nav/ul[1]/li[1]/a")
      n.should be_a(Hq::Node)
      n.should_not eq(node)
    end
  end

  describe "#xpaths" do
    pending "should return multiple nodes (version: 0.2.0)" do
      n = node.xpaths("/html/nav/ul[1]/*")
      n.text.should eq("")
    end
  end

  describe "#path" do
    it "should return the current path" do
      node.path.should eq("")
      node.xpath("/foo").path.should eq("/foo")
    end
  end

  describe "#text" do
    it "should return text if the node exists" do
      a = node.xpath("/html/body/nav/ul[1]/li[1]/a")
      a.text.should eq("crystal")
    end

    it "should raise NotFound if the node doesn't exist" do
      a = node.xpath("/xxx/a")
      expect_raises(Hq::NotFound) do
        a.text
      end
    end
  end

  describe "#[]" do
    it "should return attribute if the node exists" do
      a = node.xpath("/html/body/nav/ul[1]/li[1]/a")
      a["href"].should eq("https://github.com/crystal-lang/crystal")
    end

    it "should raise NotFound if the node doesn't exist" do
      a = node.xpath("/xxx/a")
      expect_raises(Hq::NotFound) do
        a["href"]
      end
    end
  end

  describe "#text?" do
    it "should return text if the node exists" do
      a = node.xpath("/html/body/nav/ul[1]/li[1]/a")
      a.text?.should eq("crystal")
    end

    it "should return nil if the node doesn't exist" do
      a = node.xpath("/xxx/a")
      a.text?.should eq(nil)
    end
  end

  describe "#int" do
    node = Hq.parse <<-EOF
      <html><body><div>82 users</div></body></html>
      EOF

    it "should extract first integer from content if the node exists" do
      node.xpath("/html/body/div").int.should eq(82)
    end

    it "should raise NotFound if the node exists but number is not found" do
      node = Hq.parse("<html><body><div>foo</div></body></html>")
      node = node.xpath("/html/body/div")

      expect_raises(Hq::NotFound) do
        node.int
      end
    end

    it "should raise NotFound if the node doesn't exist" do
      n = node.xpath("/xxx")
      expect_raises(Hq::NotFound) do
        n.int
      end
    end
  end

  describe "#int?" do
    node = Hq.parse <<-EOF
      <html><body><div>82 users</div></body></html>
      EOF

    it "should extract first integer from content if the node exists" do
      node.xpath("/html/body/div").int?.should eq(82)
    end

    it "should raise NotFound if the node exists but number is not found" do
      node = Hq.parse("<html>foo</html>")
      node.xpath("/html").int?.should eq(nil)
    end

    it "should raise NotFound if the node doesn't exist" do
      node.xpath("/xxx").int?.should eq(nil)
    end
  end
end
