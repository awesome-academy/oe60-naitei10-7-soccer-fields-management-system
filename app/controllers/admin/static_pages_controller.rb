# frozen_string_literal: true

module Admin
  class StaticPagesController < ApplicationController
    before_action :bookings, only: %i(index update cancel)
    before_action :load_booking, only: %i(update cancel)

    def index
      bookings_get
    end

    def show
      @user = current_user
    end

    def update
      respond_to do |format|
        if @booking.update(status: :confirmed)
          BookingMailer.booking_accepted_email(@booking).deliver_now
          format.html { redirect_to root_path, notice: t("admin.bookings.success") }
        else
          format.html { redirect_to admin_static_pages_path, notice: t("admin.bookings.fail") }
        end
        format.turbo_stream
      end
      bookings_get
    end

    def cancel
      respond_to do |format|
        if @booking.update(status: :canceled)
          BookingMailer.booking_accepted_email(@booking).deliver_now
          format.html { redirect_to admin_static_pages_path, notice: t("admin.cancel.success") }
        else
          format.html { redirect_to admin_static_pages_path, notice: t("admin.cancel.fail") }
        end
        format.turbo_stream
      end
      bookings_get
    end

    private

    def bookings
      @bookings = Booking.pending.by_ids(current_user.booking_ids)
    end

    def load_booking
      @booking = Booking.find_by id: params[:id]
      return if @booking

      flash[:danger] = t("admin.booking.not_found")
      redirect_to admin_static_pages_path
    end

    def bookings_get
      @pagy, @bookings = pagy(@bookings.includes(:user), items: Settings.PERPAGE_8)
    end
  end
end
