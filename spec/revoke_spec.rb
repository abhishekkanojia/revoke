require 'spec_helper'
require 'support/fake_model'

RSpec.describe Revoke do

  describe 'included modules' do
    it { is_expected.to include(Revoke::Constants) }
  end

  describe 'it provides revoke method to class' do

    describe 'revoke class method' do
      context 'when revoke disabled' do
        it { expect(FakeModel.respond_to?(:revoke)).to eq(false) }
      end

      context 'when revoke enabled' do
        before { FakeModel.send(:include, Revoke) }
        it { expect(FakeModel.respond_to?(:revoke)).to eq(true) }
      end
    end
  end

  describe 'revoke method adds callbacks' do
    describe 'update callback' do
      before do
        FakeModel.revoke :update, :after, 10.minutes, :creation
        @subject = FakeModel.new
      end

      it 'expect callback having name revoke_update_handler' do
        expect(@subject.respond_to?(:revoke_update_handler, true)).to eq(true)
      end
    end

    describe 'create callback' do
      before do
        FakeModel.revoke :create, :after, 10.minutes, :creation
        @subject = FakeModel.new
      end

      it 'expect callback having name revoke_create_handler' do
        expect(@subject.respond_to?(:revoke_create_handler, true)).to eq(true)
      end
    end

    describe 'destroy callback' do
      before do
        FakeModel.revoke :destroy, :after, 10.minutes, :creation
        @subject = FakeModel.new
      end

      it 'expect callback having name revoke_destroy_handler' do
        expect(@subject.respond_to?(:revoke_destroy_handler, true)).to eq(true)
      end
    end
  end

end
