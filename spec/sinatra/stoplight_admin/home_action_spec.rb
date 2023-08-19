# frozen_string_literal: true

require 'sinatra/stoplight_admin/home_action'

RSpec.describe Sinatra::StoplightAdmin::HomeAction, :redis do
  subject(:action) { described_class.new(lights_repository: lights_repository) }

  let(:lights_repository) { instance_double(Sinatra::StoplightAdmin::LightsRepository) }

  describe '#call' do
    subject(:call) { action.call }

    let(:lights) { instance_double(Array) }

    it 'returns lights and stats' do
      expect(lights_repository).to receive(:all) { lights }

      is_expected.to eq([lights])
    end
  end
end
