# frozen_string_literal: true

RSpec.describe StoplightAdmin::Actions::Home, :redis do
  subject(:action) do
    described_class.new(
      lights_repository: lights_repository,
      lights_stats: lights_stats
    )
  end

  let(:lights_repository) { instance_double(StoplightAdmin::LightsRepository) }
  let(:lights_stats) { class_double(StoplightAdmin::LightsStats) }

  describe '#call' do
    subject(:call) { action.call }

    let(:lights) { instance_double(Array) }
    let(:stats) { instance_double(Hash) }

    it 'returns lights and stats' do
      expect(lights_repository).to receive(:all) { lights }
      expect(lights_stats).to receive(:call).with(lights) { stats }

      is_expected.to eq([lights, stats])
    end
  end
end
