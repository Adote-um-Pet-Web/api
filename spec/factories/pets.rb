# frozen_string_literal: true

FactoryBot.define do
  factory :pet do
    name { FFaker::Name.name }
    species { %w[dog cat].sample }
    breed do
      if species == 'dog'
        %w[Labrador Beagle Poodle Dachshund Boxer ShihTzu Chihuahua].sample
      else
        %w[Persa Siamês MaineCoon Ragdoll Sphynx Bengala Siamese].sample
      end
    end
    age { rand(1..12) }
    age_type { %w[months years].sample }
    color { FFaker::Color.name }
    sex { %w[male female].sample }
    size { %w[small medium large].sample }
    weight { rand(1..40) }
    history { FFaker::Lorem.paragraph }
    observations { FFaker::Lorem.paragraph }
    images do
      [
        Rack::Test::UploadedFile.new(Rails.root.join('spec/support/images/pet_image.jpg')),
        Rack::Test::UploadedFile.new(Rails.root.join('spec/support/images/pet_image.jpg'))
      ]
    end
    adopted { [true, false].sample }
    association :owner, factory: :user
  end
end
