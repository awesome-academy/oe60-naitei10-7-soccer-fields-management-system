# frozen_string_literal: true
class BookingsController < ApplicationController
  load_and_authorize_resource

  layout "guest"

  before_action :logged_in_user, :load_bookings, only: %i(index destroy)
  before_action :check_booking_owner, :is_allow_cancel_booking, only: :destroy
  before_action :logged_in_user, :load_field_type, :has_overlap, only: :create

  def index; end

  def create
    @booking = current_user.bookings.new booking_params
    if @booking.save
      flash[:success] = t("field_types.booking_field_success")
      redirect_to field_type_path(@field_type)
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    respond_to do |format|
      if @booking.destroy
        current_user.send_cancel_booking_success_email
        format.html { redirect_to bookings_path, notice: t("booking.delete_success") }
      else
        format.html { redirect_to bookings_path, notice: t("booking.delete_fail") }
      end
      format.turbo_stream
    end
  end

  private

  def booking_params
    params.permit :start_time, :end_time, :field_type_id, :price_id
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

  def has_overlap
    check_field_overlap = Booking.exists?(start_time: booking_params[:start_time],
                                          field_type_id: booking_params[:field_type_id])
    return unless check_field_overlap

    flash[:danger] = t("field_type.overlap")
    redirect_to field_type_path(@field_type)
  end

  def is_allow_cancel_booking
    return if @booking.pending?

    flash[:danger] = @booking.confirmed? ? t("booking.confirmed") : t("booking.canceled")
    redirect_to booking_path
  end

  def load_bookings
    @bookings = current_user.bookings.latest
  end

  def check_booking_owner
    @booking = current_user.bookings.find_by(id: params[:id])
    return if @booking

    flash[:danger] = t("booking.not_your")
    redirect_to booking_path
  end
end
