class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::StatementInvalid, with: :not_found

  private

  def not_found
    Rails.logger.warn("404 Not Found: #{request.path}")
    render json: { error: "Not found" }, status: :not_found
  end
end
