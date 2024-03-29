# frozen_string_literal: true
require "rails_helper"

RSpec.describe BookingsController, type: :controller do
  user = FactoryBot.create(:user)
  field_type = FactoryBot.create(:field_type)
  price = FactoryBot.create(:price, field_type_id: field_type.id)
  describe "POST #create" do
    booking_params = FactoryBot.attributes_for(:booking).merge(price_id: price.id, field_type_id: field_type.id, id: field_type.id)
    context "when the user is logged in" do
      before do
        session[:user_id] = user.id
      end
      it "creates a new booking" do
        post :create, params: booking_params
      end
      it "redirects to the index page" do
        expect do
          post :create, params: booking_params
        end.to change(Booking, :count).by(1)
        expect(response).to redirect_to("http://test.host/field_types/#{booking_params[:id]}")
      end

      it "sets a flash notice" do
        expect do
          post :create, params: booking_params
        end.to change(Booking, :count).by(1)
        expect(flash[:success]).to eq(I18n.t("field_types.booking_field_success"))
      end
    end
  end
  describe "DELETE #destroy" do
    user = FactoryBot.create(:user)
    field_type = FactoryBot.create(:field_type)
    price = FactoryBot.create(:price, field_type_id: field_type.id)
    booking = Booking.create!(FactoryBot.attributes_for(:booking).merge(price_id: price.id, field_type_id: field_type.id, id: field_type.id, user_id: user.id))
    context "when the booking is destroyed" do
      before do
        session[:user_id] = user.id
      end

      it "destroys the booking" do
        expect do
          delete :destroy, params: { id: booking.id }
        end.to change(Booking, :count).by(-1)

        expect(response).to redirect_to(bookings_path)
      end
    end
  end
end
