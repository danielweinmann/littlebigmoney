class AddFinishOnceReachedGoalToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :finish_once_reached_goal, :boolean
  end
end
