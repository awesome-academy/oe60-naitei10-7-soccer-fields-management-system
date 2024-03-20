# frozen_string_literal: true

module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def log_out
    forget_user
    reset_session
    @current_user = nil
  end

  def forget_user
    cookies.delete :user_id
    cookies.delete :remember_token
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by id: user_id
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by id: user_id
      if user&.authenticate?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    current_user.present?
  end

  def current_user?(user)
    user.id == current_user.id
  end
end
