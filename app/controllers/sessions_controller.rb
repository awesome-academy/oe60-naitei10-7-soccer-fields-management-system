# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :load_user, :handle_failed_login, :check_activated, only: :create

  def new
    @user = User.new
  end

  def create
    forwarding_url = session[:forwarding_url]
    reset_session
    log_in @user
    redirect_to forwarding_url || root_path, status: :see_other
  end

  def destroy
    log_out
    redirect_to root_path, status: :see_other
  end

  private

  def load_user
    @user = User.find_by(email: params[:email])
    return if @user

    flash.now[:danger] = t("sessions.create.error_login_message")
    render :new, status: :unprocessable_entity
  end

  def handle_failed_login
    return if @user.authenticate(params[:password])

    flash.now[:danger] = t("sessions.create.error_login_message")
    render :new, status: :unprocessable_entity
  end

  def check_activated
    return if @user.activated?

    flash.now[:warning] = t("email.activation.deactivated")
    render :new, status: :unprocessable_entity
  end
end
