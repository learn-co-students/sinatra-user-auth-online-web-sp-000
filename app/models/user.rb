class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password
end
# validating attributes of our user by writing code that makes sure no one can sign up without inputting their name, email, and password.