# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, default: "", null: false
      t.text :description, default: "", null: false
      t.integer :price_amount

      t.timestamps
    end
  end
end
