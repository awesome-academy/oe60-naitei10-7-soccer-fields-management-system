# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ErrorHandlingHelper
  include SessionsHelper
  include Pagy::Backend
  include TimeHelper
  include BookingsHelper
  before_action :set_locale

  def switch_language
    locale = params[:locale]
    session[:locale] = locale
    redirect_back(fallback_location: root_path)
  end

  private

  def set_locale
    I18n.locale = session[:locale] || I18n.default_locale
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = I18n.t("application.user.not_login")
    store_location
    redirect_to root_path
  end
end
