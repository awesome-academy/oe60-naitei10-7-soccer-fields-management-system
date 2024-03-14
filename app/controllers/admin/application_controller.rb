# frozen_string_literal: true
module Admin
  class ApplicationController < ApplicationController
    before_action :is_admin

    private

    def is_admin
      return if current_user&.role == "admin"

      flash[:danger] = t("application.user.is_not_admin")
      redirect_to root_path
    end
  end
end
