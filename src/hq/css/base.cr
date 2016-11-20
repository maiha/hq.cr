class Hq::Css
  alias Raw = Myhtml::EachTagIterator | Myhtml::Node

  def self.parse(str : String)
    raw = Myhtml::Parser.new.parse(str)
    Parser.new(raw)
  end

  def self.parse(n : Myhtml::Node)
    Text.new(n)
  end

  module Finder
    def css(selector) : Node
      Nodes.new(raw.nodes(selector), selector)
    rescue err : Myhtml::Error
      case err.to_s
      when /unknown tag/i
        return None.new
      else
        raise err
      end
    end
  end

  module Node
    include Enumerable(Node)
    include Finder

    abstract def raw : Raw
    abstract def text : String
#    abstract def attributes : Hash(String, String)

    def inspect(io : IO)
      io << "Node(tag='#{name}', text='#{text_summary(20)}')"
    end

    protected def build(node)
      Hq::Css.parse(node)
    end

    protected def none
      Hq::Css::None.new
    end

    protected def text_summary(max)
      buf = text
      buf = buf.split(//)[0,max].join + "..." if buf.size > max
      return buf
    end
  end
    
#  macro method_missing(call)
#    @node.{{call.id}}
#  end
end
