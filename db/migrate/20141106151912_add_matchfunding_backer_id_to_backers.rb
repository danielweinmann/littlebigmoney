class AddMatchfundingBackerIdToBackers < ActiveRecord::Migration
  def change
    add_column :backers, :matchfunding_backer_id, :integer, foreign_key: { references: :backers }
  end
end
