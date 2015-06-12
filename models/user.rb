require 'mongo'
require 'mongo_mapper'
require 'bcrypt'

class User
	include MongoMapper::Document
	include BCrypt


	key :email, String, required: true,  unique: true
	key :name, String, required: true
	key :password, String, required: true
	key :password_hash, String, required: true

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

	# def self.authenticate(requested_email, requested_password)
	# 	u = self.find_by_email(requested_email)
	# 	u if u && u.password_hash == requested_password
 #  end


end
