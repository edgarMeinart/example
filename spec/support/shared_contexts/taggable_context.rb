# frozen_string_literal: true

RSpec.shared_context("taggable") do |opts={}|
  let(:klass) { described_class }
  let(:record) { klass.new }

  describe "#tags" do
    subject(:call) { record.tags }

    context "when attribute is not given" do
      context "and relations are blank" do
        it { is_expected.to be_blank }
      end

      context "and at least one related tag exist" do
        let(:tag) { build(:tag) }

        before do
          allow(record).to(
            receive(:base_tags).and_return([tag])
          )
        end

        it "calls unmap method once and returns unmapped tag title" do
          expect(record).to(
            receive(:unmap_tags_titles).and_call_original.once
          )

          is_expected.to include(tag.title)
          call
        end
      end
    end
  end

  describe "#tags=" do
    subject(:call) { record.tags = tags }

    context "when singular argument is given" do
      let(:tags) { "foo" }

      it "saves item anyway" do
        is_expected.to include(tags)
      end
    end

    context "when Array as arg is given" do
      let(:tags) { %w(foo bar baz) }

      it { is_expected.to include(*tags) }

      it "writes changes" do
        expect { call }.to(
          change{ record.changes }.to(
            "tags" => [[], tags]
          )
        )
      end
    end
  end

  describe "#offload_tags!" do
    subject(:call) { record.send(:offload_tags!) }

    let(:new_tags) { %w(foo bar baz foo bar baz) }

    before do
      record.tags = new_tags
    end

    it "resolves all given tags" do
      expect(record).to(
        receive(:resolve_tags_by_title).
        with(new_tags).and_call_original
      )

      call
    end
  end

  describe "#resolve_tags_by_title!" do
    subject(:call) { record.send(:resolve_tags_by_title, tag_list) }

    let(:persisted_tag) { create(:tag) }

    let(:tag_list) { [persisted_tag.title, "foobar"] }

    it "returns persisted tag and initialize missings" do
      is_expected.to include(persisted_tag, anything)
    end
  end

  describe "#unmap_tags_titles" do
    subject(:call) { record.send(:unmap_tags_titles) }

    let(:persisted?) { true }

    before do
      allow(record).to(
        receive(:persisted?).and_return(persisted?)
      )
    end

    context "when record persisted" do
      it "calls pluck over scope" do
        expect(record.base_tags).to(
          receive(:pluck).with(:title).and_call_original
        )

        is_expected.to be_empty
      end
    end

    context "when new record" do
      let(:persisted?) { false }

      it "iterates over records with map" do
        expect(record.base_tags).to(
          receive(:map).and_call_original
        )

        is_expected.to be_empty
      end
    end
  end
end
