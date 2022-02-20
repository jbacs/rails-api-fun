require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  describe 'POST /authenticate' do
    context 'valid request' do
      it 'returns a http status of :created' do
        post '/authenticate', params: { username: 'Username123', password: 'Asdf123' }
        expect(response).to have_http_status :created
      end
    end

    context 'invalid request' do
      it 'returns a http status of :unprocessable_entity' do
        post '/authenticate', params: { password: 'Asdf123' }

        expect(response).to have_http_status :unprocessable_entity
      end

      it 'returns error if username param is missing' do
        post '/authenticate', params: { password: 'Asdf123' }

        expect(response_body).to eq(
          { 'error' => 'param is missing or the value is empty: username' }
        )
      end

      it 'returns error if password param is missing' do
        post '/authenticate', params: { username: 'Username123' }

        expect(response_body).to eq(
          { 'error' => 'param is missing or the value is empty: password' }
        )
      end
    end
  end
end