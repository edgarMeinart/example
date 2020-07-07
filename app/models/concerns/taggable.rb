# frozen_string_literal: true

module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :tags,
      as: :owner, inverse_of: :owner, dependent: :destroy
  end

  def tags=(tag_names)
  end
end
