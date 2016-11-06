class Hq::NotFound < Exception
  property key

  def initialize(@key : String)
    super("Not Found: `#{key}'")
  end
end
