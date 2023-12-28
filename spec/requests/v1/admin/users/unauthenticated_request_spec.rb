# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'V1::Admin::Users without authentication', type: :request do
  context 'GET /users' do
    let(:url) { '/v1/admin/users' }
    let!(:users) { create_list(:user, 5) }

    before(:each) { get url }
    include_examples 'unauthenticated access'
  end

  context 'GET /users' do
    let(:url) { '/v1/admin/users' }
    let(:user) { create(:user) }

    before(:each) { get url }
    include_examples 'unauthenticated access'
  end

  context 'POST /users' do
    let(:url) { '/v1/admin/users' }

    before(:each) { post url }
    include_examples 'unauthenticated access'
  end

  context 'PATCH /users/:id' do
    let(:user) { create(:user) }
    let(:url) { "/v1/admin/users/#{user.id}" }

    before(:each) { patch url }
    include_examples 'unauthenticated access'
  end

  context 'DELETE /users/:id' do
    let(:user) { create(:user) }
    let(:url) { "/v1/admin/users/#{user.id}" }

    before(:each) { delete url }
    include_examples 'unauthenticated access'
  end
end
