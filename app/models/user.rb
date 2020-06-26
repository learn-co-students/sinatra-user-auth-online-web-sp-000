class User < ActiveRecord::Base
  validates_presence_of :name, :email, :password

  # attr_accessor :name, :email, :password

  # @@all = []

  # def initialize(name, email, password)
  #   @name = params[:name]
  #   @email = params[:email]
  #   @password = params[:password]
  #   @@all << self
  # end

  # def self.all
  #   @@all
  # end
end