# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pet, type: :model do
  subject { build(:pet) }

  it { is_expected.to belong_to(:owner).class_name('User').with_foreign_key('owner_id') }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:species) }
  it { is_expected.to validate_presence_of(:breed) }
  it { is_expected.to validate_presence_of(:age_type) }
  it { is_expected.to validate_presence_of(:sex) }
  it { is_expected.to validate_presence_of(:size) }
  it { is_expected.to validate_presence_of(:weight) }
  it { is_expected.to validate_presence_of(:age) }
  it { is_expected.to validate_numericality_of(:age).is_greater_than(0) }
  it { is_expected.to validate_numericality_of(:weight).is_greater_than(0) }

  it { is_expected.to define_enum_for(:species).with_values(dog: 0, cat: 1) }
  it { is_expected.to define_enum_for(:sex).with_values(male: 0, female: 1, undefined_sex: 2) }
  it { is_expected.to define_enum_for(:size).with_values(small: 0, medium: 1, large: 2, undefined_size: 3) }
  it { is_expected.to define_enum_for(:age_type).with_values(months: 0, years: 1) }
end
