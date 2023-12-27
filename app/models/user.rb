# frozen_string_literal: true

class User < ApplicationRecord
  after_create :assign_default_role

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :owned_pets, class_name: 'Pet', foreign_key: 'owner_id', dependent: :destroy

  has_many :adoptions, foreign_key: 'adopter_id'
  has_many :adopted_pets, through: :adoptions, source: :pet

  validates :name, :email, presence: true

  private

  def assign_default_role
    add_role(:user) if roles.blank?
  end
end
