class AddServiceUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :service_user_id, :string
    add_index :users, :service_user_id
  end
end
