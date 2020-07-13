# frozen_string_literal: true

class V1::ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at

  attribute(:price) { object.price.to_s }

  has_many(:base_tags, key: :tags, each_serializer: V1::TagSerializer)
end
