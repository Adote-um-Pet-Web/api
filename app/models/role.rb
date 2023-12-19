# frozen_string_literal: true

class Role < ApplicationRecord
  VALID_ROLES = %w[admin user].freeze

  has_and_belongs_to_many :users, join_table: :users_roles

  belongs_to :resource,
             polymorphic: true,
             optional: true

  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true

  scopify

  validates :name, inclusion: { in: VALID_ROLES }
end
