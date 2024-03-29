# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :author, references: :userse, null: false, foreign_key: { to_table: :users }
      t.text :body
      t.references :channel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
