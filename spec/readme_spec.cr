require "./spec_helper"

describe "README.md" do
  describe "Usage" do
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
end
