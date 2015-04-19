class AddBannerTopBottomUrlToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :banner_top_url, :text
    add_column :channels, :banner_bottom_url, :text
  end
end
