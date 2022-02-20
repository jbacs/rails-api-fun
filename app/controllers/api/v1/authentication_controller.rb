class Api::V1::AuthenticationController < Api::V1::BaseController
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  def create
    params.require(:password)

    user = User.where(email: params.require(:email)).first
    token = AuthenticationTokenService.call(user.id)

    render json: { token: token }, status: :created
  end

  private

  def parameter_missing(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end
end