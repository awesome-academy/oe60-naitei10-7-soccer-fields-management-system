# frozen_string_literal: true
class BookingsController < ApplicationController
  before_action :logged_in_user, only: :index

  def index
    @bookings = current_user.bookings.latest
  end
end
