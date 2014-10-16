class AddShowDraftsToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :show_drafts, :boolean
  end
end
