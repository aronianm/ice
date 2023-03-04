class WorkoutsController < ApplicationController
  def kanboard
    @workouts_to_do = ['Pushups', 'Jumping Jacks']
  end


  def index
  end

  def workout_table
    respond_to do |format|
      format.js{
        render "workouts/workout_table", layout: false
      }
    end
  end
end
