# frozen_string_literal: true

json.extract! @pet, :id, :name, :species, :breed, :age, :age_type, :sex, :weight, :color, :size, :owner_id, :history,
              :observations, :adopted, :created_at, :updated_at
