require "./spec_helper"

describe Hq do
  describe ".parse" do
    it "should instantiate node from String" do
      node = Hq.parse("<html></html>")
      node.should be_a(Hq::Node)
    end
  end
end
