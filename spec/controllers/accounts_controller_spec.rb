# frozen_string_literal: true
require "rails_helper"

RSpec.describe RegistrationsController, type: :controller do
  describe "GET new" do
    it "assigns a new User to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "returns a successful response" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    let(:valid_params) do
      {
        email: "test@example.com",
        first_name: "John",
        last_name: "Doe",
        phone_number: "123456789",
        password: "Abc123$!",
        password_confirmation: "Abc123$!"
      }
    end

    context "with valid params" do
      it "creates a new User" do
        expect do
          post :create, params: { user: valid_params }
        end.to change(User, :count).by(1)
      end

      it "sends activation email to the user" do
        expect_any_instance_of(User).to receive(:send_activation_email)
        post :create, params: { user: valid_params }
      end

      it "sets flash info message" do
        post :create, params: { user: valid_params }
        expect(flash[:info]).to eq(I18n.t("email.activation.subject"))
      end

      it "redirects to root path" do
        post :create, params: { user: valid_params }
        expect(response).to redirect_to(root_url)
      end

      it "returns a see other response" do
        post :create, params: { user: valid_params }
        expect(response).to have_http_status(:see_other)
      end
    end

    context "with invalid params" do
      let(:invalid_params) { valid_params.merge(email: "") }

      it "does not create a new User" do
        expect do
          post :create, params: { user: invalid_params }
        end.not_to change(User, :count)
      end

      it "renders the new template" do
        post :create, params: { user: invalid_params }
        expect(response).to render_template(:new)
      end

      it "returns an unprocessable entity response" do
        post :create, params: { user: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
