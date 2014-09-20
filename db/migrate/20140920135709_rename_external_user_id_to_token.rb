class RenameExternalUserIdToToken < ActiveRecord::Migration
  def change
    rename_column :users, :external_user_id, :token
  end
end
