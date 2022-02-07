# frozen_string_literal: true

class CreateServers < ActiveRecord::Migration[7.0]
  def change
    create_table :servers do |t|
      t.string :name
      t.references :owner, references: :users, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end
  end
end
