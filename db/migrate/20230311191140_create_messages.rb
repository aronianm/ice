class CreateMessages < ActiveRecord::Migration[7.0]
    def change
    create_table :messages do |t|
      t.integer :user_id 
      t.integer :room_id
      t.text :content
    end
    create_table :rooms do |t|
      t.string :name
      t.boolean :is_private, :default => true
      t.integer :user_id
      t.integer :trainor_id
      t.timestamps
    end

    add_foreign_key :messages, :rooms, column: :room_id, on_delete: :cascade
    add_foreign_key :messages, :users, column: :user_id, on_delete: :cascade
    add_foreign_key :rooms, :users, column: :user_id, on_delete: :cascade
    add_foreign_key :rooms, :users, column: :trainor_id, on_delete: :cascade

    add_index :rooms, [ :user_id, :trainor_id ], unique: true
  end
end
