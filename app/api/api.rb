# frozen_string_literal: true

class API < Grape::API
  prefix "api"
  format :json

  formatter :json, Grape::Formatter::ActiveModelSerializers
  error_formatter :json, Grape::Formatter::ActiveModelSerializers

  namespace :v1 do
    mount V1::ProductsApi => ""
  end
end
