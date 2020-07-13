# frozen_string_literal: true

module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable, dependent: :destroy, class_name: "Tagging"
    has_many(
      :base_tags,
      through: :taggings,
      source: :tag,
      class_name: "Tag"
    )

    attribute :tags

    after_save :offload_tags!
  end

  def tags
    value = super || (@tags ||= unmap_tags_titles)
  end

  def tags=(tag_list)
    tag_list = Array.wrap(tag_list).delete_if(&:blank?)

    set_attribute_was(:tags, tags)

    super(tag_list)
  end

  private

    def offload_tags!
      self.base_tags = resolve_tags_by_title(tags)
    end

    def resolve_tags_by_title(tag_list)
      tag_list.map { |tag_title| Tag.where(title: tag_title).first_or_initialize }
    end

    def unmap_tags_titles
      return base_tags.pluck(:title) if persisted?

      base_tags.map(&:title)
    end
end
