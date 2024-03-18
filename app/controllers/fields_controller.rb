# frozen_string_literal: true

class FieldsController < ApplicationController
  def show
    @field = Field.find params[:id]
  end
  
  def index
    @pagy, @fields = pagy Field.all, items: Settings.PERPAGE_8
  end
end
