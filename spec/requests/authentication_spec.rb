require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let(:user) { create(:user) }

  describe 'POST /authenticate' do
    context 'valid request' do
      before do
        post '/authenticate', params: { email: user.email, password: 'Asdf123' }
      end

      it 'returns a http status of :created' do
        expect(response).to have_http_status :created
      end

      it 'returns jwt token' do
        decoded_token = JWT.decode(response_body["token"], AuthenticationTokenService::HMAC_SECRET, true, { algorithm: AuthenticationTokenService::ALGORITHM_TYPE })
        expect(decoded_token).to eq(
          [{ 'user_id' => user.id }, { 'alg' => 'HS256' }]
        )
      end
    end

    context 'invalid request' do
      it 'returns a http status of :unprocessable_entity' do
        post '/authenticate', params: { password: 'Asdf123' }

        expect(response).to have_http_status :unprocessable_entity
      end

      it 'returns error if email param is missing' do
        post '/authenticate', params: { password: 'Asdf123' }

        expect(response_body).to eq(
          { 'error' => 'param is missing or the value is empty: email' }
        )
      end

      it 'returns error if password param is missing' do
        post '/authenticate', params: { email: user.email }

        expect(response_body).to eq(
          { 'error' => 'param is missing or the value is empty: password' }
        )
      end
    end
  end
end