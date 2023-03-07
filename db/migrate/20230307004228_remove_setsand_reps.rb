class RemoveSetsandReps < ActiveRecord::Migration[7.0]
  def change
    remove_column :exercises, :sets
    remove_column :exercises, :reps
    remove_column :exercises, :duration
  end
end
