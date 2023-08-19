# frozen_string_literal: true

RSpec.describe StoplightAdmin::LightsRepository, :redis do
  subject(:repository) { described_class.new(data_store: data_store) }

  let(:data_store) { Stoplight::DataStore::Redis.new(redis) }
  let(:light) do
    Stoplight(name)
      .with_data_store(data_store)
  end
  let(:name) { 'lights-repository' }

  describe '#all' do
    subject(:lights) { repository.all }

    context 'when there are no lights' do
      it 'returns empty array' do
        is_expected.to be_empty
      end
    end

    context 'when there are lights' do
      before do
        light.run { raise 'whoops' }
      rescue
        nil
      end

      it 'returns light' do
        is_expected.to contain_exactly(
          have_attributes(
            name: name,
            color: 'green',
            state: 'unlocked',
            failures: contain_exactly(
              have_attributes(
                error_class: 'RuntimeError',
                error_message: 'whoops'
              )
            )
          )
        )
      end
    end
  end
end
