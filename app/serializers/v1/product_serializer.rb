# frozen_string_literal: true

class V1::ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  attribute(:price) { object.price.to_s }
  has_many(:tags, each_serializer: V1::TagSerializer)
end
