class AddApiToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api, :boolean, default: false
  end
end
