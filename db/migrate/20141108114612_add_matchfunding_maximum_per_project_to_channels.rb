class AddMatchfundingMaximumPerProjectToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :matchfunding_maximum_per_project, :float
  end
end
