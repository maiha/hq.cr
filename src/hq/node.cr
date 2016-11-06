class Hq::Node
  property path

  def initialize(@try : Try(XML::Node), @path : String = "")
  end

  def node
    @try.get
  end
  
  def node?
    @try.get?
  end
  
  def xpath(path : String)
    new_path = @path + path
    found = @try.map{|n| n.xpath_node(path) || raise NotFound.new(new_path)}
    Node.new(found, new_path)
  end

  def [](key)
    @try.map(&.[key]).get
  end

  ######################################################################
  ### conversions
  
  def text
    text(&.to_s)
  end

  def text
    @try.map{|n| yield(n.text.to_s)}.get
  end

  def int
    text { |s| (s =~ /(-?\d+)/) ? $1.to_i : raise NotFound.new(@path)}
  end
  
  macro def_boolean_method(name)
    def {{name}}?
      {{name}}
    rescue NotFound
      nil
    end
  end

  def_boolean_method text
  def_boolean_method int
end
