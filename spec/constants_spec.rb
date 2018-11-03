require 'spec_helper'

RSpec.describe Revoke::Constants do
  describe 'ACTION' do
    it { expect(described_class::ACTION).to eq([:update, :destroy]) }
    it { expect(described_class::ACTION).to be_frozen }
  end

  describe 'EVENT' do
    describe 'event to be instance of hash' do
      it { expect(described_class::EVENT).to be_instance_of(Hash) }
    end

    describe 'EVENT to be frozen' do
      it { expect(described_class::EVENT).to be_frozen }
    end

    describe 'EVENT to have value' do
      it 'have value ' do
        expect(described_class::EVENT).to eq({
          after: '>'
        })
      end
    end
  end

  describe 'ACTION_MAP' do
    describe 'ACTION_MAP to instance of hash' do
      it { expect(described_class::ACTION_MAP).to be_instance_of(Hash) }
    end

    describe 'ACTION_MAP to be frozen' do
      it { expect(described_class::ACTION_MAP).to be_frozen }
    end

    describe 'ACTION_MAP to match data' do
      it 'defines action map to have value' do
        expect(described_class::ACTION_MAP).to eq({
          creation: 'created_at',
          updation: 'updated_at',
          deletion: 'deleted_at'
        })
    end
    end
  end
end
