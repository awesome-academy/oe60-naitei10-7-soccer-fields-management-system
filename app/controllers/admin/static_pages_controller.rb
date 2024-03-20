# frozen_string_literal: true

module Admin
  class StaticPagesController < Admin::AdminController
    before_action :bookings, only: :index
    before_action :load_booking, only: %i(update cancel pending)

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
    def pending
      if @booking.update(status: :pending)
        BookingMailer.booking_accepted_email(@booking).deliver_now
        flash[:success] = t("admin.bookings.success")
        redirect_to admin_static_pages_path
      else
        flash[:danger] = t("admin.bookings.fail")
        redirect_to root_path
      end
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
      @bookings = current_user.fields.joins(field_types: :bookings).select("*")
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
