# frozen_string_literal: true

class FieldTypesController < ApplicationController
  layout "guest"
  before_action :load_field_type, :load_reviews, :load_field_type_booked, only: :show

  def show; end

  private

  def load_reviews
    @reviews = Review.reviews_newest_by(@field_type.id)
  end

  def load_field_type_booked
    @field_types_booked = @field_type.bookings
  end

  def load_field_type
    @field_type = FieldType.find_by(id: params[:id])
    return if @field_type

    flash[:danger] = t("field_types.not_found")
    redirect_to root_path
  end
end
