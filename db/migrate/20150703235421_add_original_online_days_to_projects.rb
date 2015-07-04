class AddOriginalOnlineDaysToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :original_online_days, :integer
  end
end
