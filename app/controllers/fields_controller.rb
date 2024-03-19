# frozen_string_literal: true

class FieldsController < ApplicationController
  layout "guest"

  include FieldsHelper
  before_action :load_field, only: :show

  def show; end

  def index
    @pagy, @fields = pagy Field.all, items: Settings.PERPAGE_8
  end

  private

  def load_field
    @field = Field.find_by(id: params[:id])
    return if @field

    flash[:danger] = t("field_types.not_found")
    redirect_to root_path
  end
end
