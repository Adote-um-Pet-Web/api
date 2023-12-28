# frozen_string_literal: true
require 'rails_helper'

describe 'Admin Home', type: :request do
  let!(:auth_user) do
    auth_user = create(:user)
    auth_user.add_role(:admin)
    auth_user
  end

  it 'Test Home Message' do
    get '/v1/admin/home', headers: auth_header(auth_user)
    expect(body_json).to eq('message' => 'Hello World')
  end

  it 'Test Home Status' do
    get '/v1/admin/home', headers: auth_header(auth_user)
    expect(response).to have_http_status(:ok)
  end
end
