# frozen_string_literal: true

RSpec.describe V1::TagSerializer do
  subject { described_class.new(model).as_json }

  let(:model) { create(:tag) }

  it "generates valid structure" do
    is_expected.to(
      include(
        id: model.id,
        title: model.title,
        created_at: model.created_at,
        updated_at: model.updated_at
      )
    )
  end
end
