class User < ActiveRecord::Migration
  def change
    create_table :user do |t|
      t.string :name
      t.string :email
      t.string :password
    end
  end
end
