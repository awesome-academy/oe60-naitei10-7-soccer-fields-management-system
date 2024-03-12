# frozen_string_literal: true

class FieldTypesController < ApplicationController
  before_action :logged_in_user, :has_overlap, only: :update
  before_action :load_field_type, only: :show

  def show
    @bookings = @field_type.bookings
  end

  def update
    @booking = current_user.bookings.new field_type_params
    if @booking.save
      flash[:success] = t("field_types.booking_field_success")
      redirect_to field_type_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def has_overlap
    check_field_overlap = Booking.exists?(start_time: field_type_params[:start_time],
                                          field_type_id: field_type_params[:field_type_id])
    return unless check_field_overlap

    flash[:danger] = t("filed_type.overlap")
    redirect_to field_type_path
  end

  def load_field_type
    @field_type = FieldType.find_by(id: params[:id])
    return if @field_type

    redirect_to root_path
    flash[:danger] = t("field_types.not_found")
  end

  def field_type_params
    params.permit :start_time, :end_time, :field_type_id
  end
end
