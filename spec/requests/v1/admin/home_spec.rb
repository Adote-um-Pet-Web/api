require 'rails_helper'

describe 'Admin Home', type: :request do
  let(:user) { create(:user) }

  it 'Test Home Message' do
    get '/v1/admin/home', headers: auth_header(user)
    expect(body_json).to eq('message' => 'Hello World')
  end

  it 'Test Home Status' do
    get '/v1/admin/home', headers: auth_header(user)
    expect(response).to have_http_status(:ok)
  end
end
