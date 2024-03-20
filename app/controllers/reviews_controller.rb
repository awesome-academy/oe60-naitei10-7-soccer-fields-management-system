# frozen_string_literal: true
class ReviewsController < ApplicationController
  def update
    session[:rating] = params[:rating]
  end

  def create
    @review = current_user.reviews.new(field_type_id: params[:field_type_id], content: params[:content], rating: session[:rating])
    respond_to do |format|
      if @review.save
        format.html { redirect_to field_path, notice: t("review.review_success") }
      else

        format.html { redirect_to field_path, notice: t("review.review_fail") }
      end
      format.turbo_stream
    end
  end
end
