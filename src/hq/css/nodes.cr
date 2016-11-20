class Hq::Css::Nodes
  include  Hq::Css::Node

  getter raw
  getter tag
  
  def initialize(@raw : Myhtml::EachTagIterator, @tag : String)
  end

  def name
    tag
  end

  def each
    raw.each do |node|
      yield(build(node))
    end
  end

  def text
    map(&.text).join("\n")
  end

  def inspect(io : IO)
    io << "Node(tag=#{name}, size=#{size}, text=#{text_summary(20)}"
  end
end
