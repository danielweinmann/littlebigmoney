class AddCreditsFeeToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :credits_fee, :float
  end
end
