require "stoplight"
require "zeitwerk"

module StoplightAdmin
  COLORS = [
    GREEN = Stoplight::Color::GREEN,
    YELLOW = Stoplight::Color::YELLOW,
    RED = Stoplight::Color::RED
  ].freeze

  class << self
    def loader!
      @loader ||= Zeitwerk::Loader.for_gem.tap do |loader|
        loader.ignore("#{__dir__}/sinatra")
        loader.setup
      end
    end
  end
end

StoplightAdmin.loader!
