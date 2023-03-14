class WorkoutProgram < ActiveRecord::Migration[7.0]
  def change
    create_table :workout_programs do |t|
      t.integer :workout_id
      t.integer :program_id
    end
  end
end
