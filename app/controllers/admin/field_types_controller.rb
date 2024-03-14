# frozen_string_literal: true
module Admin
  class FieldTypesController < ApplicationController
    before_action :load_field, only: %i(show)

    def index; end

    def new
      @field_type = FieldType.new
    end

    def show
      @pagy, @field_types = pagy @field.field_types, items: Settings.PERPAGE_8
    end

    def create
      @field = Field.find_by(id: params[:field_id])
      @field_type = @field.field_types.build(field_type_params)
      @field_type.is_availible ||= true
      build_prices(params)
      if @field_type.save
        flash[:success] = t("admin.field_type.create_success")
        redirect_to admin_field_type_path(params[:field_id])

      else
        flash[:danger] = t("admin.field_type.create_fail")
        render :new
      end
    end

    private

    def load_field
      @field = Field.find_by(id: params[:id])
      return if @field

      flash[:warning] = t("admin.field.field_not_found")
      redirect_to admin_fields_path
    end

    def field_type_params
      params.permit(:field_type_name)
    end

    def build_prices(params)
      %w(Morning Afternoon Evening).each do |period|
        price_value = params["#{period}_Price".downcase.to_sym]
        @field_type.prices.build(name: period[0], price: price_value)
      end
    end
  end
end
