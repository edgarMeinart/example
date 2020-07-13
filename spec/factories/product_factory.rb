# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { FFaker::Product.product_name }
    description { FFaker::AWS.product_description }
    price { 42 }

    with_tags

    trait :with_tags do
      tags { %i[tag_a tag_b tab_c] }
    end
  end
end
