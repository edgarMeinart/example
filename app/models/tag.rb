# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy

  validates :title, presence: true, uniqueness: true
end
