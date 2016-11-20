struct Hq::Css::None
  include Hq::Css::Nodes
  include Hq::Css::Node

  def initialize
  end

  def text
    "(none)"
  end

  def name
    "(none)"
  end

  def each(&block)
  end

  def [](index : Int32)
    self
  end

  def [](index : String)
    "(none)"
  end

  def []?(index : String)
    nil
  end
end
