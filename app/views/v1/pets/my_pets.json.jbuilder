# frozen_string_literal: true

json.array! @pets, partial: 'v1/pets/pet', as: :pet
