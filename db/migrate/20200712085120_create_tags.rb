# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[5.2]
  def change
    table_name = :tags

    create_table table_name do |t|
      t.string :title, default: "", null: false

      t.timestamps
    end

    add_index table_name, :title, unique: true
  end
end
