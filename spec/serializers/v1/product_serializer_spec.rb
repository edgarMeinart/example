# frozen_string_literal: true

RSpec.describe V1::ProductSerializer do
  subject { described_class.new(model).as_json }

  let(:model) { create(:product) }

  it "generates valid structure" do
    is_expected.to(
      include(
        name: model.name,
        description: model.description,
        price: model.price.to_s,
        created_at: model.created_at,
        updated_at: model.updated_at,
        tags: anything
      )
    )
  end
end
