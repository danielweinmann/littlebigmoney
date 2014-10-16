class AddLegendToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :legend, :text
  end
end
