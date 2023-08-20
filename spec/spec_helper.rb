$LOAD_PATH.push(File.join(File.expand_path("."), "lib"))

require "stoplight"
require "stoplight_admin"
require_relative "support/database_cleaner"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  begin
    config.filter_run_when_matching :focus
    config.disable_monkey_patching!
    config.warnings = true
    config.default_formatter = "doc" if config.files_to_run.one?
    config.order = :random

    Kernel.srand config.seed
  end
end
