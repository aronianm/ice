class WorkoutsController < ApplicationController
  def kanboard
    @workouts_to_do = ['Pushups', 'Jumping Jacks']
  end
end
