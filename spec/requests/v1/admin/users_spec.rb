# frozen_string_literal: true

require 'rails_helper'
require 'pry'

RSpec.describe 'V1::Admin::Users', type: :request do
  let!(:auth_user) { create(:user) }

  context 'GET /users' do
    let(:url) { '/v1/admin/users' }
    let!(:users) { create_list(:user, 5) }

    it 'returns all Users including the auth user' do
      get url, headers: auth_header(auth_user)
      expected_users = users + [auth_user]
      expect(body_json).to match_array expected_users.as_json(only: %i[id name email])
    end

    it 'returns sucess status' do
      get url, headers: auth_header(auth_user)
      expect(response).to have_http_status(:ok)
    end
  end

  context 'POST /users' do
    let(:url) { '/v1/admin/users' }

    context 'with valid params' do
      let(:user_params) { { user: attributes_for(:user) }.to_json }

      it 'adds a new User' do
        expect do
          post url, headers: auth_header(auth_user), params: user_params
        end.to change(User, :count).by(1)
      end

      it 'returns last added User' do
        post url, headers: auth_header(auth_user), params: user_params
        expected_user = User.last.as_json
        expect(body_json).to eq expected_user
      end

      it 'returns success status' do
        post url, headers: auth_header(auth_user), params: user_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      invalid_cases_hash = [
        { field: :name, value: nil, message: I18n.t('errors.messages.blank') },
        { field: :email, value: nil, message: I18n.t('errors.messages.blank') },
        { field: :email, value: 'invalidemail@email', message: I18n.t('errors.messages.invalid_email') }
      ]

      invalid_cases_hash.each do |case_data|
        context "with invalid #{case_data[:field]} (#{case_data[:value]})" do
          let(:user_invalid_params) do
            { user: attributes_for(:user, case_data[:field] => case_data[:value]) }.to_json
          end

          it 'does not add a new User' do
            expect { post url, headers: auth_header(auth_user), params: user_invalid_params }
              .to_not change(User, :count)
          end

          it "returns error messages for #{case_data[:field]}" do
            post url, headers: auth_header(auth_user), params: user_invalid_params
            expect(body_json['errors']).to have_key(case_data[:field].to_s)
            expect(body_json['errors'][case_data[:field].to_s]).to include(case_data[:message])
          end

          it 'returns unprocessable_entity status' do
            post url, headers: auth_header(auth_user), params: user_invalid_params
            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end
    end
  end
end
