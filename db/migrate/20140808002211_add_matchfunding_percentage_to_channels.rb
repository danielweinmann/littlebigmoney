class AddMatchfundingPercentageToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :matchfunding_percentage, :integer
  end
end
