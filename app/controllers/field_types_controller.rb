# frozen_string_literal: true

class FieldTypesController < ApplicationController
  before_action :load_field_type, :load_field_type_booked, only: %i(show create)
  before_action :logged_in_user, :has_overlap, only: :create
  before_action :load_reviews, only: :show

  def show; end

  def create
    @booking = current_user.bookings.new field_type_params
    if @booking.save
      flash[:success] = t("field_types.booking_field_success")
      redirect_to field_type_path(@field_type)
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def load_reviews
    @reviews = Review.review_records(@field_type.id)
  end

  def has_overlap
    check_field_overlap = Booking.exists?(start_time: field_type_params[:start_time],
                                          field_type_id: field_type_params[:field_type_id])
    return unless check_field_overlap

    flash[:danger] = t("field_type.overlap")
    redirect_to field_type_path(@field_type)
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

  def field_type_params
    params.permit :start_time, :end_time, :field_type_id, :price_id
  end
end
