# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ErrorHandlingHelper
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
end
