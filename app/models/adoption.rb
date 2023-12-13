# frozen_string_literal: true

class Adoption < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :adopter, class_name: 'User', foreign_key: 'adopter_id'
  belongs_to :pet

  enum status: { in_review: 0, approved: 1, declined: 2, finalized: 3, cancelled: 4, on_hold: 5 }

  validates :owner, :adopter, :pet, :date, :status, presence: true
end
