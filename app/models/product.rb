# frozen_string_literal: true

class Product < ApplicationRecord
  include Taggable

  validates :name, :description, :price, presence: true
end
