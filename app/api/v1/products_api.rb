# frozen_string_literal: true

class V1::ProductsApi < Grape::API
  helpers V1::Helpers

  helpers do
    def collection
      Product.all
    end
  end

  namespace :products do
    get do
      collection
    end

    params do
      group :data, type: Hash do
        requires :id
        requires :type
        group :attributes, type: Hash do
          requires :name
          requires :description
          requires :price
          optional :tags
        end
      end
    end
    post do
      collection.create!(resource_params)
    end

    route_param :id do
      get do
        resource
      end

      params do
        group :data, type: Hash do
          requires :id
          requires :type
          group :attributes, type: Hash do
            optional :name
            optional :description
            optional :price
            optional :tags
          end
        end
      end
      patch do
        resource.update!(resource_params)

        resource
      end

      delete do
        resource.destroy!
      end
    end
  end
end
