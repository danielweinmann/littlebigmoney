class AddColumnsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :history, :text
    add_column :projects, :cause, :text
    add_column :projects, :description, :text
    add_column :projects, :impact,  :text
    add_column :projects, :budget, :text
    add_column :projects, :implementation, :text
  end
end
