class AddAsteticsToExercise < ActiveRecord::Migration[7.0]
  def down
    remove_foreign_key :users_roles, :roles, column: :role_id
    remove_foreign_key :users_roles, :users, column: :user_id
  end

  def up
    add_column :exercises, :sets, :integer
    add_column :exercises, :reps, :integer
    add_column :exercises, :duration, :string

    add_foreign_key :users_roles, :roles, column: :role_id
    add_foreign_key :users_roles, :users, column: :user_id
  end
end
