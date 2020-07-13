# frozen_string_literal: true

class API < Grape::API
  prefix "api"
  format :json

  namespace :v1 do
    formatter :json, Grape::Formatter::ActiveModelSerializers
    error_formatter :json, Grape::ErrorFormatter::ActiveModelSerializers

    rescue_from ActiveRecord::RecordNotFound do |error_var|
      error!(
        {
          errors: [
            {
              status: 404,
              title: error_var.class.name,
              detail: error_var.message
            }
          ]
        },
        404
      )
    end

    rescue_from ActiveRecord::RecordInvalid do |error_var|
      error!(error_var.record, 400)
    end

    mount V1::ProductsApi => ""
    mount V1::TagsApi => ""
  end
end
