class AddTypeToExercise < ActiveRecord::Migration[7.0]
  def change
    add_column :exercises, :typ, :string
  end
end
