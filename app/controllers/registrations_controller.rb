# frozen_string_literal: true

class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.create user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t("email.activation.subject")
      redirect_to root_url, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private
    
    def user_params
      params.permit(:email, :first_name, :last_name, :phone_number, :password, :password_confirmation)
    end
end
