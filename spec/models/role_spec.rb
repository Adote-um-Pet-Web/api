# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  it { should validate_inclusion_of(:name).in_array(%w[admin user]) }
end
