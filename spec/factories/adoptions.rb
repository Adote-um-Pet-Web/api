# frozen_string_literal: true

FactoryBot.define do
  factory :adoption do
    association :owner, factory: :user
    association :pet, factory: :pet
    association :adopter, factory: :user
    date { FFaker::Time.date }
    status { Adoption.statuses.keys.sample }
  end
end
