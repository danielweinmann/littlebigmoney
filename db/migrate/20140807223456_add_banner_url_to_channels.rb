class AddBannerUrlToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :banner_url, :text
  end
end
