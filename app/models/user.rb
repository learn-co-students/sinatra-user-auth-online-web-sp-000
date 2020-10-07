class User < ActiveRecord::Base
  attr_accessor :name, :email, :password

  validates_presence_of :name, :email, :password
end
