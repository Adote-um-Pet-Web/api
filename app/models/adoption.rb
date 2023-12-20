# frozen_string_literal: true

class Adoption < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :adopter, class_name: 'User', foreign_key: 'adopter_id'
  belongs_to :pet

  enum status: { in_review: 0, approved: 1, declined: 2, finalized: 3, cancelled: 4, on_hold: 5 }

  validates :owner, :adopter, :pet, :date, :status, presence: true

  validate :validate_adoption_availability, on: :create

  private

  def validate_adoption_availability
    last_adoption = pet&.adoptions&.order(:updated_at)&.last

    return unless last_adoption.present? && !last_adoption.declined? && !last_adoption.cancelled?

    errors.add(:pet, 'adoption already finalized or in review')
  end
end
