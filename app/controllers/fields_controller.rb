# frozen_string_literal: true

class FieldsController < ApplicationController
  def index
    @field = Field.new
  end

  def show; end
end
