# frozen_string_literal: true

RSpec.describe Product, type: :model do
  it_behaves_like("taggable")

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
  end
end
