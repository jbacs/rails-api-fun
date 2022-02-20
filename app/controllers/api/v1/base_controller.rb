class Api::V1::BaseController < ApplicationController
  def success_response(response_success_payload, status_code = :ok)
    render json: response_success_payload, status: status_code
  end

  def error_response(response_error_payload, status_code)
    render json: response_error_payload, status: status_code
  end
end
