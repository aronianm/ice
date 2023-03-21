class AddStatusofCreationtoProgram < ActiveRecord::Migration[7.0]
  def change
     add_column :programs, :ready_tag, :boolean
  end
end
