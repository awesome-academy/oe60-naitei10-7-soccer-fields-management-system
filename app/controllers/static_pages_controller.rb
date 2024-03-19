# frozen_string_literal: true

class StaticPagesController < ApplicationController
  layout "guest"
  def home
    @fields = Field.search_by_name(params[:search]).sorted_by_name
    @pagy, @fields = pagy @fields, items: Settings.PERPAGE_8
    return unless @fields.blank?

    flash.now[:alert] = t("controller.static_pages.not_found_field")
  end
end
