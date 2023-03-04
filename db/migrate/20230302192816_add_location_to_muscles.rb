class AddLocationToMuscles < ActiveRecord::Migration[7.0]
  def change
    add_column :muscles, :location, :string
  end
end
