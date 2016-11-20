module Hq::Css::Nodes
  include Enumerable(Node)

  def text
    map(&.text).join("\n")
  end

  def [](index : Int32)
    # FIXME: replace this with something like `Enumerable#at(n)`
    each_with_index do |node, i|
      return node if i == index
    end
    return Hq::Css::None.new
  end
end

class Hq::Css::EachTag
  include Hq::Css::Nodes

  getter tag
  
  def initialize(@raw : Myhtml::EachTagIterator, @tag : String)
  end

  def name
    tag
  end

  def each
    @raw.each do |node|
      yield(Hq::Css::Element.new(node))
    end
  end

  def inspect(io : IO)
    io << "Node(tag=#{name}, size=#{size}, text=#{text_summary(20)}"
  end
end
