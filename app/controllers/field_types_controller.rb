class FieldTypesController < ApplicationController
  def show
    @field_type = FieldType.find params[:id]
  end

end
