# frozen_string_literal: true
require "rails_helper"

RSpec.describe AccountsController, type: :controller do
  describe "POST activations" do
    let(:activation_digest) { "some_activation_digest" }
    let(:user) { instance_double(User, authenticated?: true, activated: false, active: nil) }

    before do
      allow(User).to receive(:find_by).with(activation_digest:).and_return(user)
    end

    it "loads the user from activation_digest" do
      post :activations, params: { activation_digest: }
      expect(assigns(:user)).to eq(user)
    end

    it "checks activation" do
      expect(user).to receive(:authenticated?).with(:activation, activation_digest)
      post :activations, params: { activation_digest: }
    end

    it "activates the user if not activated" do
      expect(user).to receive(:active)
      post :activations, params: { activation_digest: }
    end

    it "redirects to root path" do
      post :activations, params: { activation_digest: }
      expect(response).to redirect_to(root_path)
    end

    it "sets flash message" do
      post :activations, params: { activation_digest: }
      expect(flash[:success]).to eq(I18n.t("email.activation.activated"))
    end
  end
end
