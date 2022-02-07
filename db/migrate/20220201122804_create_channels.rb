# frozen_string_literal: true

class CreateChannels < ActiveRecord::Migration[7.0]
  def change
    create_table :channels do |t|
      t.string :name
      t.references :server, null: false, foreign_key: true

      t.timestamps
    end
  end
end
