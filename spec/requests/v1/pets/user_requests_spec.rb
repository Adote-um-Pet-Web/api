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

  context 'POST /v1/pets' do
    let(:url) { '/v1/pets' }

    context 'with valid params' do
      let(:pet_params) { { pet: attributes_for(:pet), owner_id: auth_user.id }.to_json }

      it 'adds a new Pet' do
        expect do
          post url, headers: auth_header(auth_user), params: pet_params
        end.to change(Pet, :count).by(1)
      end

      it 'returns last added Pet' do
        post url, headers: auth_header(auth_user), params: pet_params
        expected_pet = Pet.last.as_json
        expect(body_json).to eq expected_pet
      end

      it 'returns success status' do
        post url, headers: auth_header(auth_user), params: pet_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters, empty fields' do
      invalid_cases_hash = [
        { field: :name, value: nil, message: I18n.t('errors.messages.blank') },
        { field: :species, value: nil, message: I18n.t('errors.messages.blank') },
        { field: :breed, value: nil, message: I18n.t('errors.messages.blank') },
        { field: :age, value: nil, message: I18n.t('errors.messages.blank') },
        { field: :age_type, value: nil, message: I18n.t('errors.messages.blank') },
        { field: :sex, value: nil, message: I18n.t('errors.messages.blank') },
        { field: :size, value: nil, message: I18n.t('errors.messages.blank') },
        { field: :weight, value: nil, message: I18n.t('errors.messages.blank') }
      ]

      invalid_cases_hash.each do |case_data|
        context "with invalid #{case_data[:field]} (#{case_data[:value]})" do
          let(:pet_invalid_params) do
            { pet: attributes_for(:pet, case_data[:field] => case_data[:value]),
              owner_id: auth_user.id }.to_json
          end

          it 'does not add a new Pet' do
            expect { post url, headers: auth_header(auth_user), params: pet_invalid_params }
              .to_not change(Pet, :count)
          end

          it "returns error messages for #{case_data[:field]}" do
            post url, headers: auth_header(auth_user), params: pet_invalid_params
            expect(body_json['errors']).to have_key(case_data[:field].to_s)
            expect(body_json['errors'][case_data[:field].to_s]).to include(case_data[:message])
          end

          it 'returns unprcessable_entity status' do
            post url, headers: auth_header(auth_user), params: pet_invalid_params
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end
    end

    context 'with invalid numeric values' do
      invalid_cases_hash = [
        { field: :age, value: -1, message: I18n.t('errors.messages.greater_than', count: 0) },
        { field: :age, value: 'abc', message: I18n.t('errors.messages.not_a_number') },
        { field: :weight, value: -1, message: I18n.t('errors.messages.greater_than', count: 0) },
        { field: :weight, value: 'abc', message: I18n.t('errors.messages.not_a_number') }
      ]

      invalid_cases_hash.each do |case_data|
        context "with invalid #{case_data[:field]} (#{case_data[:value]})" do
          let(:pet_invalid_params) do
            { pet: attributes_for(:pet, case_data[:field] => case_data[:value]),
              owner_id: auth_user.id }.to_json
          end

          it 'does not add a new Pet' do
            expect { post url, headers: auth_header(auth_user), params: pet_invalid_params }
              .to_not change(Pet, :count)
          end

          it "returns error messages for #{case_data[:field]}" do
            post url, headers: auth_header(auth_user), params: pet_invalid_params
            expect(body_json['errors']).to have_key(case_data[:field].to_s)
            expect(body_json['errors'][case_data[:field].to_s]).to include(case_data[:message])
          end

          it 'returns unprcessable_entity status' do
            post url, headers: auth_header(auth_user), params: pet_invalid_params
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end
    end

    context 'with invalid enum values' do
      invalid_cases_hash = [
        { field: :species, value: 'invalid_species', message: I18n.t('errors.messages.inclusion') },
        { field: :sex, value: 'invalid_sex', message: I18n.t('errors.messages.inclusion') },
        { field: :size, value: 'invalid_size', message: I18n.t('errors.messages.inclusion') },
        { field: :age_type, value: 'invalid_age_type', message: I18n.t('errors.messages.inclusion') }
      ]

      invalid_cases_hash.each do |case_data|
        context "with invalid #{case_data[:field]} (#{case_data[:value]})" do
          let(:pet_invalid_params) do
            { pet: attributes_for(:pet, case_data[:field] => case_data[:value]),
              owner_id: auth_user.id }.to_json
          end

          it 'does not add a new Pet' do
            expect { post url, headers: auth_header(auth_user), params: pet_invalid_params }
              .to_not change(Pet, :count)
          end

          it "returns error messages for #{case_data[:field]}" do
            post url, headers: auth_header(auth_user), params: pet_invalid_params
            expect(body_json['errors']).to eq "'#{case_data[:value]}' is not a valid #{case_data[:field]}"
          end

          it 'returns unprcessable_entity status' do
            post url, headers: auth_header(auth_user), params: pet_invalid_params
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end
    end
  end
end
