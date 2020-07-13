# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    title {  FFaker::Tweet.tags(1) }
  end
end
