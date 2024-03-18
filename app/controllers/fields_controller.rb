# frozen_string_literal: true

class FieldsController < ApplicationController
  include FieldsHelper
  before_action :load_field, only: %i(show make_favorite)

  def show; end

  private

  def load_field
    @field = Field.find params[:id]
    return if @field

    flash[:danger] = t("field_types.not_found")
    redirect_to root_path
  end

  def index
    @pagy, @fields = pagy Field.all, items: Settings.PERPAGE_8
  end
end
