class Hq::Css::Element
  include Hq::Css::Node

  getter raw
  delegate attributes, to: raw
  delegate "[]", "[]?", to: attributes
  
  def initialize(@raw : Myhtml::Node)
  end

  def name : String
    raw.tag_name
  end

  def text : String
    if size == 0
      raw.tag_text
    else
      map(&.text.as(String)).join("\n")
    end
  end

  def each
    raw.children.each do |node|
      yield(build(node))
    end
  end
end
