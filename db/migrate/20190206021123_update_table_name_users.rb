class UpdateTableNameUsers < ActiveRecord::Migration
  def change
    rename_table :shows, :users
  end
end
