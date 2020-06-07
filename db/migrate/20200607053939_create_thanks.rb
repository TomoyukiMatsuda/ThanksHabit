class CreateThanks < ActiveRecord::Migration[5.2]
  def change
    create_table :thanks do |t|
      t.string :content, null: false
      t.references :user, foreign_key: true, null: false
      t.references :receiver, foreign_key: { to_table: :users }, null: false
      t.references :group, foreign_key: true, null: false

      t.timestamps
    end
  end
end
