class CreateGroupUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_users do |t|
      t.references :user, foreign_key: true, null: false
      t.references :group, foreign_key: true, null: false
      t.boolean :permission, default: false, null: false

      t.timestamps
      t.index [:user_id, :group_id], unique: true
    end
  end
end