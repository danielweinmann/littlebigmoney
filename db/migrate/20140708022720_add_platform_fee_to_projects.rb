class AddPlatformFeeToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :platform_fee, :float
  end
end
