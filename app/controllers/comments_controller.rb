# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :assign_dom_each_comment, only: :create

  def create
    @comment = current_user.comments.new comment_params
    respond_to do |format|
      if @comment.save
        format.html { redirect_to field_path, notice: t("comment.comment_success") }
      else
        format.html { redirect_to field_path, notice: t("comment.comment_fail") }
      end
      format.turbo_stream
    end
  end

  private

  def assign_dom_each_comment
    @dom_id = params[:dom_id]
  end

  def comment_params
    params.permit :review_id, :content, :parent_comment_id
  end
end
