require 'spec_helper'

RSpec.describe Revoke do
  describe 'version' do
    it { expect(described_class::VERSION).to eq('0.1.0') }
  end
end
