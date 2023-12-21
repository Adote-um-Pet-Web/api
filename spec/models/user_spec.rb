# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:owned_pets).class_name('Pet').with_foreign_key('owner_id') }
  it { is_expected.to have_many(:adoptions).with_foreign_key('adopter_id') }
  it { is_expected.to have_many(:adopted_pets).through(:adoptions).source(:pet) }

  describe 'callbacks' do
    it 'assigns default role after creation' do
      user = FactoryBot.create(:user)
      expect(user.has_role?(:user)).to be_truthy
    end
  end
end
