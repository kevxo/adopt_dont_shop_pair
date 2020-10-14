class RenameNameToUserName < ActiveRecord::Migration[5.2]
  def change
    rename_column :reviews, :name, :user_name
  end
end
