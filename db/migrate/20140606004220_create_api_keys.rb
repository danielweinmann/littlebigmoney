class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :access_token
      t.references :user
      t.timestamp :expires_at

      t.timestamps
    end
    add_index :api_keys, :user_id
  end
end
