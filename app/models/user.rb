# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :owned_pets, class_name: 'Pet', foreign_key: 'owner_id'

  has_many :adoptions, foreign_key: 'adopter_id'
  has_many :adopted_pets, through: :adoptions, source: :pet
end
