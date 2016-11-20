require "./spec_helper"

describe "README.md" do
  describe "xpath" do
    it "should work" do
      node = Hq.parse("<html><body><div>82 users</div></body></html>")
      node.xpath("/html/body/div").text.should eq("82 users")
      node.xpath("/html/body/div").int.should eq(82)
      node.xpath("/html/body/nav").int?.should eq(nil)
      node.xpath("/html/body").path.should eq("/html/body")

      expect_raises(Hq::NotFound, "Not Found: `/html/div'") do
        node.xpath("/html/div").text
      end
    end
  end

  describe "css" do
    it "should work" do
      nodes = Hq::Css.parse <<-EOF
        <a href="https://github.com/crystal-lang/crystal" class="official">crystal</a>
        <a href="https://github.com/maiha/hq.cr">hq.cr</a>
        EOF
      nodes.css("a").each_with_index do |a, i|
        vals = [a["href"], a["class"]?]
        case i
        when 0; vals.should eq(["https://github.com/crystal-lang/crystal", "official"])
        when 1; vals.should eq(["https://github.com/maiha/hq.cr", nil])
        end
      end
    end
  end
end
