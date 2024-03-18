class FavoriteFieldTypesController < ApplicationController
  include FieldsHelper
  before_action :load_field, only: :create

  def create
    handle_error_and_redirect do
      @favorite = FavoriteFieldType.new(field_type_id: params[:field_type_id], user_id: current_user.id)
      respond_to do |format|
        if @favorite.save
          format.html { redirect_to field_path, notice: t("fields.favorite_success") }
          format.turbo_stream
        else
          format.html { redirect_to field_path, notice: t("fields.favorite_fail") }
          format.turbo_stream
        end
      end
    end
  end

  private

  def load_field
    @field = Field.find params[:id]
    return if @field

    flash[:danger] = t("field_types.not_found")
    redirect_to root_path
  end
end
