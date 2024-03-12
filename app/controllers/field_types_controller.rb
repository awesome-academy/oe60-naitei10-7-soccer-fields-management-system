# frozen_string_literal: true

class FieldTypesController < ApplicationController
  before_action :load_field_type, only: :show
  
  def show; end
  
  private
  
  def load_field_type
    @field_type = FieldType.find_by(id: params[:id])
    return if @field_type
    
    flash[:danger] = t("field_types.not_found")
    redirect_to root_path
  end
end
