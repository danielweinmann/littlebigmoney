class AddNameEsToCategories < ActiveRecord::Migration
  def up
    add_column :categories, :name_es, :string
    execute("UPDATE categories SET name_es = name_pt")
  end
  def down
    remove_column :categories, :name_es
  end
end
