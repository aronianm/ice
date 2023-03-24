class CreateProgramTables < ActiveRecord::Migration[7.0]
  def change
    create_table :programs do |t|
      t.string :name
      t.integer :created_by
      t.integer :updated_by
      t.timestamps
    end

    create_table :program_exercises do |t|
      t.integer :program_id
      t.integer :exercise_id
      t.timestamps
    end

    create_table :user_programs do |t|
      t.integer :program_id
      t.integer :user_id
    end

    create_table :exercise_users do |t|
      t.integer :program_id
      t.integer :user_id
      t.integer :exercise_id
      t.integer :sets
      t.integer :reps
      t.integer :duration
      t.text :notes
    end

    add_foreign_key :program_exercises, :programs, column: :program_id, on_delete: :cascade
    add_foreign_key :program_exercises, :exercises, column: :exercise_id, on_delete: :cascade

    add_foreign_key :user_programs, :programs, column: :program_id, on_delete: :cascade
    add_foreign_key :user_programs, :users, column: :user_id, on_delete: :cascade

    add_foreign_key :exercise_users, :programs, column: :program_id, on_delete: :cascade
    add_foreign_key :exercise_users, :users, column: :user_id, on_delete: :cascade
    add_foreign_key :exercise_users, :exercises, column: :exercise_id, on_delete: :cascade
    # program can have many users
    # program can have many exercises
  end
end
