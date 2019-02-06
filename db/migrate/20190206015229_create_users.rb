class CreateUsers < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.string :name
      t.string :email
      t.string :password
    end
  end
end
