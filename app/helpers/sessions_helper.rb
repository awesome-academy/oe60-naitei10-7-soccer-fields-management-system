# frozen_string_literal: true

module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
