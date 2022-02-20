class Api::V1::BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed

  include Pagination

  private

  def success_response(response_success_payload, status_code = :ok)
    render json: response_success_payload, status: status_code
  end

  def error_response(response_error_payload, status_code)
    render json: response_error_payload, status: status_code
  end

  def not_destroyed(error)
    render json: { error: error.record.errors }, status: :unprocessable_entity
  end
end
