# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review
  belongs_to :parent_comment
end
