class Users < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
    end
  end
end

#does this need id as Primary key
#how check database for users with pry or sqlite?: User.find(:id)
