# frozen_string_literal: true

class V1::TagSerializer < ActiveModel::Serializer
  attributes :id, :name
end
