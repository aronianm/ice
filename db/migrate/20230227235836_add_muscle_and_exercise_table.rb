class AddMuscleAndExerciseTable < ActiveRecord::Migration[7.0]
  def change
    create_table :exercises do |t|
      t.string :name, null: false
      t.integer :target_muscle_id, null: false
      t.integer :target_sub_muscle_id
      t.text :definition
      t.integer :created_by, null: false
      t.integer :updated_by, null: false
      t.timestamps
    end

    create_table :muscles do |t|
      t.string :name
      t.integer :created_by, null: false
      t.integer :updated_by, null: false
      t.timestamps
    end

    add_index :exercises, [:name, :target_muscle_id, :created_by], unique: true
    add_foreign_key :exercises, :muscles, column: :target_muscle_id
    add_foreign_key :exercises, :muscles, column: :target_sub_muscle_id
    add_foreign_key :exercises, :users, column: :created_by
    add_foreign_key :exercises, :users, column: :updated_by

    add_foreign_key :muscles, :users, column: :created_by
    add_foreign_key :muscles, :users, column: :updated_by
  end
end
