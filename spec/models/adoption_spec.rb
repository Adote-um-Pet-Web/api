# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Adoption, type: :model do
  subject { build(:adoption) }
  it { is_expected.to belong_to(:owner).class_name('User').with_foreign_key('owner_id') }
  it { is_expected.to belong_to(:adopter).class_name('User').with_foreign_key('adopter_id') }
  it { is_expected.to belong_to(:pet) }

  it { is_expected.to validate_presence_of(:owner) }
  it { is_expected.to validate_presence_of(:adopter) }
  it { is_expected.to validate_presence_of(:pet) }

  it { is_expected.to validate_presence_of(:date) }
  it { is_expected.to validate_presence_of(:status) }

  it {
    is_expected.to define_enum_for(:status).with_values(in_review: 0, approved: 1, declined: 2, finalized: 3,
                                                        cancelled: 4, on_hold: 5)
  }

  describe 'validate_adoption_availability' do
    let(:owner) { FactoryBot.create(:user) }
    let(:adopter) { FactoryBot.create(:user) }
    let(:pet) { FactoryBot.create(:pet, owner:) }

    context 'when pet has no adoptions' do
      it 'allows creating a new adoption' do
        adoption = FactoryBot.build(:adoption, owner:, adopter:, pet:)
        expect(adoption).to be_valid
      end
    end

    context 'when the last adoption is declined or cancelled' do
      %i[declined cancelled].each do |status|
        it "allows creating a new adoption after a #{status} adoption" do
          FactoryBot.create(:adoption, owner:, adopter:, pet:, status:)
          new_adoption = FactoryBot.build(:adoption, owner:, adopter:, pet:)
          expect(new_adoption).to be_valid
        end
      end
    end

    context 'when the last adoption is not declined or cancelled' do
      Adoption.statuses.except('declined', 'cancelled').each do |status|
        it "does not allow creating a new adoption if the last status is #{status.first}" do
          FactoryBot.create(:adoption, owner:, adopter:, pet:, status: status.first)
          new_adoption = FactoryBot.build(:adoption, owner:, adopter:, pet:)
          expect(new_adoption).not_to be_valid
          expect(new_adoption.errors[:pet]).to include('adoption already finalized or in review')
        end
      end
    end
  end
end
