# frozen_string_literal: true

class Pet < ApplicationRecord
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  has_many :adoptions
  has_many :adopters, through: :adoptions, source: :adopter

  validates :name, :species, :breed, :age, :age_type, :sex, :size, :weight, presence: true
  validates :age, :weight, numericality: { greater_than: 0 }

  enum species: { dog: 0, cat: 1 }
  enum sex: { male: 0, female: 1, undefined_sex: 2 }
  enum size: { small: 0, medium: 1, large: 2, undefined_size: 3 }
  enum age_type: { months: 0, years: 1 }
end
