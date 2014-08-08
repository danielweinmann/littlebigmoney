class AddMatchfundingFactorToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :matchfunding_factor, :float
  end
end
