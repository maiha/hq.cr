require "./spec_helper"

describe Hq::Css::Node do
  nodes = Hq::Css.parse <<-EOF
    <ul class="menu">
      <li><a href="https://github.com/crystal-lang/crystal" class="official">crystal</a></li>
      <li><a href="https://github.com/maiha/hq.cr">hq.cr</a></li>
    </ul>
    EOF

  describe "#attributes" do
    it "should return attributes for the key" do
      nodes.css("li")[0].first.attributes.should eq({"href" => "https://github.com/crystal-lang/crystal", "class" => "official"})
    end
  end
  
  describe "#[key]" do
    it "should return an attribute for the key" do
      nodes.css("li")[1].first["href"].should eq("https://github.com/maiha/hq.cr")
    end
  end
end
