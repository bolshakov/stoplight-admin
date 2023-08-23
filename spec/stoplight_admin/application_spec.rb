# frozen_string_literal: true

RSpec.describe StoplightAdmin::Application do
  context "smoke test" do
    it "registers itself as a sinatra module" do
      expect(described_class).to respond_to(:registered)
    end
  end
end
