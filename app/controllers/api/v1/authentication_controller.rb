class Api::V1::AuthenticationController < Api::V1::BaseController
  class AuthenticationError < StandardError; end

  rescue_from ActionController::ParameterMissing, with: :parameter_missing
  rescue_from AuthenticationError, with: :handle_unauthenticated

  def create
    raise AuthenticationError unless user.authenticate(params.require(:password))
    token = AuthenticationTokenService.call(user.id)
    render json: { token: token }, status: :created
  end

  private

  def user
    @user ||= User.where(email: params.require(:email)).first
  end

  def parameter_missing(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end

  def handle_unauthenticated
    head :unauthorized
  end
end