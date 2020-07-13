# frozen_string_literal: true

class V1::TagSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :updated_at
end
