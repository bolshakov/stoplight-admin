# frozen_string_literal: true

module StoplightAdmin
  class Dependencies
    # @!attribute data_store
    #   @return [Stoplight::DataStore::Base]
    attr_reader :data_store
    private :data_store

    # @param data_store [Stoplight::DataStore::Base]
    def initialize(data_store:)
      @data_store = data_store
    end

    # @return [StoplightAdmin::LightsRepository]
    def lights_repository
      StoplightAdmin::LightsRepository.new(data_store: data_store)
    end

    # @return [StoplightAdmin::Actions::Home]
    def home_action
      StoplightAdmin::Actions::Home.new(
        lights_repository: lights_repository,
        lights_stats: StoplightAdmin::LightsStats
      )
    end

    # @return [StoplightAdmin::Actions::Stats]
    def stats_action
      StoplightAdmin::Actions::Stats.new(
        lights_repository: lights_repository,
        lights_stats: StoplightAdmin::LightsStats
      )
    end

    # @return [StoplightAdmin::Actions::Lock]
    def lock_action
      StoplightAdmin::Actions::Lock.new(lights_repository: lights_repository)
    end

    # @return [StoplightAdmin::Actions::Unlock]
    def unlock_action
      StoplightAdmin::Actions::Unlock.new(lights_repository: lights_repository)
    end

    # @return [StoplightAdmin::Actions::LockGreen]
    def green_action
      StoplightAdmin::Actions::LockGreen.new(lights_repository: lights_repository)
    end

    # @return [StoplightAdmin::Actions::LockRed]
    def red_action
      StoplightAdmin::Actions::LockRed.new(lights_repository: lights_repository)
    end

    # @return [StoplightAdmin::Actions::LockAllGreen]
    def green_all_action
      StoplightAdmin::Actions::LockAllGreen.new(lights_repository: lights_repository)
    end
  end
end
