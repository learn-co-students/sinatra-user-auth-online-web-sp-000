class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password
  #attr_accessor :name, :email, :password
  
  #def initialize(name: name, email: email, password: password)
   # @name = name
    #@email = email
    #@password = password
  #end
  
end