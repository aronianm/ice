class AddTrainorIdUserProgram < ActiveRecord::Migration[7.0]
  def change
    add_column :user_programs, :trainor_id, :integer
  end
end
