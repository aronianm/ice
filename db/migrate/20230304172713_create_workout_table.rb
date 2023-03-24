class CreateWorkoutTable < ActiveRecord::Migration[7.0]
  def change
    create_table :exercise_workouts do |t|
      t.integer :workout_id
      t.integer :exercise_id
      t.timestamps
    end
    create_table :workouts do |t|
      t.string :name
      t.date :day
      t.text :notes
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end

    add_foreign_key :exercise_workouts, :workouts, column: :workout_id, on_delete: :cascade
    add_foreign_key :exercise_workouts, :exercises, column: :exercise_id, on_delete: :cascade
  end
end
