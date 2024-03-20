# frozen_string_literal: true

module Admin
  class StaticPagesController < Admin::AdminController
    before_action :bookings, only: :index
    before_action :load_booking, only: %i(update cancel pending)

    def index
      @pagy, @bookings = pagy(@bookings.includes(:user), items: Settings.PERPAGE_8)
    end

    def show
      @user = current_user
    end

    def update
      if @booking.update(status: :confirmed)
        BookingMailer.booking_accepted_email(@booking).deliver_now
        flash[:success] = t("admin.bookings.success")
        redirect_to admin_static_pages_path
      else
        flash[:danger] = t("admin.bookings.fail")
        redirect_to root_path
      end
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
      if @booking.update(status: :canceled)
        BookingMailer.booking_rejected_email(@booking).deliver_now
        flash[:success] = t("admin.cancel.success")
        redirect_to admin_static_pages_path
      else
        flash[:danger] = t("admin.cancel.fail")
        redirect_to root_path
      end
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
  end
end
