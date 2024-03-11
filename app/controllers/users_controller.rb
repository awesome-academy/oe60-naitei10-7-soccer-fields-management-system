class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new show)
  before_action :load_user, except: %i(index new)
  before_action :correct_user, only: %i(edit update)

  def index
    @pagy, @users = pagy User.all, items: Settings.PAGE_10
  end

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = I18n.t("model.user.update_success")
      redirect_to @user
    else
      render root_path
    end
  end

  private

  def load_user
    @user = User.find_by(id: params[:id])
    return if @user

    flash[:warning] = I18n.t("model.user.not_found")
    redirect_to root_path
  end

  def correct_user
    return if current_user?(@user)

    flash[:error] = I18n.t("model.user.edit_error")
    redirect_to root_path
  end

  def user_params
    params.permit :first_name, :last_name,:phone_number, :password, :password_confirmation
  end
end
