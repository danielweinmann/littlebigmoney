class AddBackgroundColorsToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :background_color, :string
    add_column :channels, :banner_background_color, :string
  end
end
