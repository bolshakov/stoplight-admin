require_relative '../../spec_helper'
require 'sinatra/stoplight_admin'

RSpec.describe Sinatra::StoplightAdmin do
  context 'smoke test' do
    it 'registers itself as a sinatra module' do
      expect(described_class).to respond_to(:registered)
    end
  end
end
