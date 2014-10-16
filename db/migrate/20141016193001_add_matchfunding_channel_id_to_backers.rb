class AddMatchfundingChannelIdToBackers < ActiveRecord::Migration
  def change
    add_column :backers, :matchfunding_channel_id, :integer, foreign_key: { references: :channels }
  end
end
