class AddMatchfundingUserIdToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :matchfunding_user_id, :integer, foreign_key: { references: :users }
  end
end
