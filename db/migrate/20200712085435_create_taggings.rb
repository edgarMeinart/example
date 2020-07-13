# frozen_string_literal: true

class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    table_name = :taggings

    create_table table_name do |t|
      t.references :tag, foreign_key: true
      t.references :taggable, polymorphic: true

      t.timestamps
    end

    add_index table_name, [:taggable_id, :taggable_type]
  end
end
