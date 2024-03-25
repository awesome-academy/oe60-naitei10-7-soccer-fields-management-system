# frozen_string_literal: true
module Admin
  class FieldsController < ApplicationController
    before_action :load_field, :is_booking, only: %i(destroy)

    def index
      load_user_fields
    end

    def new
      @field = Field.new
    end

    def create
      @field = current_user.fields.build field_params
      @field.image.attach(field_params[:image])
      if @field.save
        flash[:success] = t("admin.field.create_success")
        redirect_to admin_fields_path
      else
        flash.now[:danger] = t("admin.field.create_fail")
        load_user_fields
        render :index
      end
    end

    def destroy
      @field = Field.find(params[:id])
      if @field.destroy
        flash[:success] = t("admin.field.delete_success")
        redirect_to admin_fields_path
      else
        flash[:danger] = t("admin.field.delete_fail")
        redirect_to root_path
      end
    end

    private

    def load_user_fields
      @pagy, @fields = pagy(current_user.fields, items: Settings.PERPAGE_8)
    end

    def load_field
      @field = current_user.fields.find_by id: params[:id]
      return if @field

      flash[:warning] = t("admin.field.field_not_found")
      redirect_to admin_fields_path
    end

    def field_params
      params.permit(:name, :description, :phone_number, :address, :image)
    end

    def is_booking
      return if @field.field_types.flat_map(&:bookings).empty?

      flash[:danger] = t("admin.field.can_destroy")
      redirect_to admin_fields_path
    end
  end
end
