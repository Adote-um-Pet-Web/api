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
end
