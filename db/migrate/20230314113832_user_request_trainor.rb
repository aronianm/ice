class UserRequestTrainor < ActiveRecord::Migration[7.0]
  def change
    create_table :user_trainors  do |t|
      t.integer :user_id
      t.integer :trainor_id
      t.boolean :accepted
      t.timestamps
    end

    add_foreign_key :user_trainors, :users, column: :user_id
    add_foreign_key :user_trainors , :users, column: :trainor_id
    drop_table :personal_trainor_users
  end
end
