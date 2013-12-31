class AddConvertedValueAndConvertedCurrencyToBackers < ActiveRecord::Migration
  def change
    add_column :backers, :converted_value, :float
    add_column :backers, :converted_currency, :string
  end
end
