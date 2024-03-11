class PasswordResetsController < ApplicationController
  before_action :load_user, only: %i(edit create update)
  before_action :valid_user, :check_expiration, only: %i(edit update)
  before_action :check_password_presence, only: :update

  def new; end

  def edit; end

  def create
    @user.create_reset_digest
    @user.send_password_reset_email
    flash[:info] = t("email.activation.email_instructions")
    redirect_to root_url
  end

  def update
    if @user.update(user_params)
      log_in(@user)
      @user.update_column :reset_digest, nil
      flash[:success] = t("email.activation.password_update_success")
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end

  def load_user
    @user = User.find_by email: params[:email] || params.dig(:password_reset, :email).downcase
    return if @user

    flash[:danger] = t "model.user.not_found"
    render :new
  end

  def valid_user
    return if @user.activated && @user.authenticated?(:reset, params[:id])

    flash[:danger] = t("email.activation.user_actived")
    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t("email.activation.password_expired")
    redirect_to new_password_reset_url
  end

  def check_password_presence
    return unless user_params[:password].empty?

    @user.errors.add :password, t("email.activation.password_reset_error")
    render :edit
  end
end
