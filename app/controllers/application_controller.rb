class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::StatementInvalid, with: :not_found

  private

  def not_found(exception = nil)
    Rails.logger.warn("404 Not Found: #{request.path} | #{exception&.class}: #{exception&.message}")
    render json: { error: "Not found" }, status: :not_found
  end
end
