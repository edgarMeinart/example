# frozen_string_literal: true

module V1::Helpers
  def collection
    raise NotImplementedError.new("#{ __callee__ } not implemented")
  end

  def resource
    collection.find(params[:id])
  end

  def resource_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(
      declared(params, include_missing: false), except: [:id]
    )
  end
end
