module Hq
  def self.parse(str)
    Node.new(Try(XML::Node).try{ XML.parse_html(str) })
  end
end
