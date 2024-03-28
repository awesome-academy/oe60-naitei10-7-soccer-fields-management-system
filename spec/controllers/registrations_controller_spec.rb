# frozen_string_literal: true
require "rails_helper"

RSpec.describe RegistrationsController, type: :controller do
  describe "GET new" do
    before { get :new }

    it "assigns a new User to @user" do
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the new template" do
      expect(response).to render_template(:new)
    end

    it "returns a successful response" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    user = FactoryBot.attributes_for(:user)
    context "with valid params" do
      it "creates a new User" do
        expect do
          post :create, params: { user: }
        end.to change(User, :count).by(1)
      end

      it "sends activation email to the user" do
        expect_any_instance_of(User).to receive(:send_activation_email)
        post :create, params: { user: }
      end

      it "sets flash info message" do
        post :create, params: { user: }
        expect(flash[:info]).to eq(I18n.t("email.activation.subject"))
      end

      it "redirects to root path" do
        post :create, params: { user: }
        expect(response).to redirect_to(root_url)
      end

      it "returns a see other response" do
        post :create, params: { user: }
        expect(response).to have_http_status(:see_other)
      end
    end

    context "with invalid params" do
      let(:invalid_params) { FactoryBot.attributes_for(:user).merge(email: "") }

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
