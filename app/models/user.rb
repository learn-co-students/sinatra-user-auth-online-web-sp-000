class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password, :users

  # attr_accessor :name, :email, :password

  def initialize(name, email, password, users)
    @name = name
    @email = email
    @password = password
    @users = users
  end
end