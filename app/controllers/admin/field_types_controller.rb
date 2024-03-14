# frozen_string_literal: true
module Admin
  class FieldTypesController < ApplicationController
    before_action :load_field, only: %i(show create)
    before_action :load_field_type, only: %i(destroy update)
    before_action :has_booking, only: :destroy

    def index; end

    def new
      @field_type = FieldType.new
    end

    def show
      @pagy, @field_types = pagy @field.field_types, items: Settings.PERPAGE_8
    end

    def create
      @field_type = @field.field_types.build(field_type_params)
      build_prices(params)
      if @field_type.save
        flash[:success] = t("admin.field_type.create_success")
        redirect_to admin_field_type_path(params[:field_id])

      else
        flash[:danger] = t("admin.field_type.create_fail")
        render :new
      end
    end

    def destroy
      if @field_type.destroy
        flash[:success] = t("admin.field.delete_success")
        redirect_to admin_fields_path
      else
        flash[:danger] = t("admin.field.delete_fail")
        redirect_to root_path
      end
    end

    def update
      if @field_type.update(field_type_params)
        update_prices(params)
        flash[:success] = t("admin.field_type.update_success")
        redirect_to admin_field_type_path(@field_type.field_id)
      else
        flash[:danger] = t("admin.field_type.update_fail")
        render :edit
      end
    end

    private

    def load_field
      id = params[:id] || params[:field_id]
      @field = Field.find_by(id:)
      return if @field

      flash[:warning] = t("admin.field.field_not_found")
      redirect_to admin_fields_path
    end

    def load_field_type
      @field_type = FieldType.find_by(id: params[:id])
      return if @field_type

      flash[:warning] = t("admin.field.field_type_not_found")
      redirect_to admin_fields_path
    end

    def field_type_params
      params.require(:field_type).permit(:field_type_name)
    end

    def build_prices(params)
      Price.names.each do |period|
        price_value = params["#{period[0]}_Price".downcase.to_sym]
        @field_type.prices.build(name: period[0][0], price: price_value)
      end
    end

    def update_prices(prices_params)
      return unless prices_params && prices_params[:field_type]

      %w(Morning Afternoon Evening).each do |period|
        price = prices_params[:field_type]["#{period.downcase}_price"]
        @field_type.prices.find_or_initialize_by(name: period[0]).update(price:)
      end
    end

    def has_booking
      return if @field_type.bookings.pending.empty?

      flash[:danger] = t("admin.field.can_destroy")
      redirect_to admin_fields_path
    end
  end
end
