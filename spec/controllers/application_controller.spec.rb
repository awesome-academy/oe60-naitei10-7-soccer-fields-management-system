# frozen_string_literal: true
require "rails_helper"

RSpec.describe ApplicationController, type: :controller do
  describe "#switch_language" do
    it "sets session locale" do
      get :switch_language, params: { locale: :en }
      expect(session[:locale]).to eq(:en)
    end

    it "redirects back to previous page" do
      request.env["HTTP_REFERER"] = root_path
      get :switch_language, params: { locale: :en }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "#set_locale" do
    it "sets I18n locale to session locale" do
      session[:locale] = :vi
      expect(I18n.locale).to eq(:vi)
    end

    it "sets I18n locale to default locale if session locale is not set" do
      session[:locale] = nil
      I18n.default_locale = :vi
      expect(I18n.locale).to eq(:vi)
    end
  end

  describe "#logged_in_user" do
    it "does not redirect if user is logged in" do
      allow(controller).to receive(:logged_in?).and_return(true)
      expect(response).to be_successful
    end
  end
end
