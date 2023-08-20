require "stoplight"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/sinatra")
loader.setup

module StoplightAdmin
  COLORS = [
    GREEN = Stoplight::Color::GREEN,
    YELLOW = Stoplight::Color::YELLOW,
    RED = Stoplight::Color::RED
  ].freeze
end
