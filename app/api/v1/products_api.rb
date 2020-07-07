# frozen_string_literal: true

class V1::ProductsApi < Grape::API
  helpers do
    def collection
      Product.all
    end

    def product
      collection.find(params[:id])
    end

    def product_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(
        declared(params, include_missing: false), except: [:id]
      )
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
          optional :tags, as: :tag_list
        end
      end
    end
    post do
      Product.create!(product_params)
    end

    route_param :id do
      get do
        product
      end

      params do
        group :data, type: Hash do
          requires :id
          requires :type
          group :attributes, type: Hash do
            optional :name
            optional :description
            optional :price
            optional :tags, as: :tag_list
          end
        end
      end
      patch do
        product.update!(product_params)

        product
      end

      delete do
        product.destroy!

        product
      end
    end
  end
end
