class AddWeighgttoExericseUser < ActiveRecord::Migration[7.0]
  def change
    add_column :exercise_users, :weight, :integer
  end
end
