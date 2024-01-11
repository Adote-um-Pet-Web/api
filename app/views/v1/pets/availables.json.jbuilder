# frozen_string_literal: true

json.array! @pets do |pet|
  json.extract! pet, :id, :name, :species, :breed, :age, :age_type, :sex, :weight, :color, :size, :adopted
end
