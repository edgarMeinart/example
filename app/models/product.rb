# frozen_string_literal: true

class Product < ApplicationRecord
  acts_as_taggable_on :tags

  monetize :price_amount

  validates :name, :description, :price_amount, presence: true
end
