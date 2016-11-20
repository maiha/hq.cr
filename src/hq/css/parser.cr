class Hq::Css::Parser
  include Finder
  getter raw
  
  def initialize(@raw : Myhtml::Parser)
  end
end
