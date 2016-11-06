require "spec"
require "../src/hq"

def fixture_menu_html : String
  File.read("#{__DIR__}/fixtures/menu.html")
end
