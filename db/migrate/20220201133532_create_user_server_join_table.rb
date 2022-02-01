class CreateUserServerJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :server_memberships do |t|
      t.references :member, references: :users, foreign_key: { to_table: :users }, null: false
      t.references :server, foreign_key: true, null: false

      t.timestamps
    end
  end
end

