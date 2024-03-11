# frozen_string_literal: true

module ErrorHandlingHelper
  def handle_error_and_redirect
    yield
  rescue StandardError
    flash[:danger] = t("application.server.error_message")
    redirect_to root_path
  end
end
