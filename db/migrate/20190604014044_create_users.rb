# rake db:create_migration NAME=create_users
class CreateUsers < ActiveRecord::Migration
  def change
      create_table :users do |t|
        t.string :name
        t.string :password
        t.string :email
      end
  end
end
