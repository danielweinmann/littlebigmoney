class AddMatchfundingMaximumToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :matchfunding_maximum, :float
  end
end
