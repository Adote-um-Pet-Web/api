# frozen_string_literal: true

shared_examples 'forbidden access' do
  it 'returns forbidden status' do
    expect(response).to have_http_status(:forbidden)
  end

  it 'returns error message' do
    expect(response.body).to match(/Forbidden access|not allowed/)
  end
end
