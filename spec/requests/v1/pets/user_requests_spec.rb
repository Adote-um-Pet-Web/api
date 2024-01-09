# frozen_string_literal: true

require 'rails_helper'
require 'pry'

RSpec.describe 'V1::Pets as :user', type: :request do
  let!(:auth_user) { create(:user) }

  context 'GET /v1/pets/my_pets' do
    let(:url) { '/v1/pets/my_pets' }
    let!(:pets) { create_list(:pet, 5, owner: auth_user) }

    it 'returns all user_auth pets as owner' do
      get url, headers: auth_header(auth_user)
      expected_pets = Pet.where(owner: auth_user)
      expect(body_json).to match_array expected_pets.as_json(only: %i[id name species breed sex owner_id adopted
                                                                      created_at updated_at])
    end

    it 'returns sucess status' do
      get url, headers: auth_header(auth_user)
      expect(response).to have_http_status(:ok)
    end
  end

  context 'GET /v1/pets/my_pets/:id' do
    let!(:pet) { create(:pet, owner: auth_user) }
    let(:url) { "/v1/pets/my_pets/#{pet.id}" }

    it 'returns the pet detail if owned by auth_user' do
      get url, headers: auth_header(auth_user)
      expected_pet = Pet.find(pet.id).as_json
      expect(body_json).to eq(expected_pet)
    end

    it 'returns sucess status' do
      get url, headers: auth_header(auth_user)
      expect(response).to have_http_status(:ok)
    end
  end

  context 'GET /v1/pets/availables' do
    let(:url) { '/v1/pets/availables' }
    let!(:pets_availables) { create_list(:pet, 5, owner: auth_user, adopted: false) }
    let!(:pets_unavailables) { create_list(:pet, 5, owner: auth_user, adopted: true) }

    it 'returns all avaliable pets' do
      get url, headers: auth_header(auth_user)
      expected_pets = Pet.where(adopted: false)
      expect(body_json).to match_array expected_pets.as_json(only: %i[pet id name species breed age
                                                                      age_type sex weight color size adopted])
    end

    it 'returns sucess status' do
      get url, headers: auth_header(auth_user)
      expect(response).to have_http_status(:ok)
    end
  end

  context 'GET /v1/pets/availables/:id' do
    let!(:pet) { create(:pet, owner: auth_user, adopted: false) }
    let(:url) { "/v1/pets/availables/#{pet.id}" }

    it 'returns available pet details if user is authenticated' do
      get url, headers: auth_header(auth_user)
      expected_pet = Pet.find_by!(id: pet.id, adopted: false)
      expected_pet_with_owner_information = expected_pet.as_json
                                                        .merge('owner' => expected_pet.owner
                                                        .as_json(only: %i[id name email]))

      expect(body_json).to eq(expected_pet_with_owner_information)
    end

    it 'returns sucess status' do
      get url, headers: auth_header(auth_user)
      expect(response).to have_http_status(:ok)
    end
  end
end
