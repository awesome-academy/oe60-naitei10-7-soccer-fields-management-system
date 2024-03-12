# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def home
    @pagy, @fields = pagy Field.sorted_by_name, items: Settings.PERPAGE_8
  end
end
