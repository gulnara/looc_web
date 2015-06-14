require 'mongo'
require 'mongo_mapper'
require 'bcrypt'

class User
	include MongoMapper::Document
	include BCrypt


	key :email, String, required: true,  unique: true
	key :name, String, required: true
	key :encrypted_password, String
  timestamps!

  def encrypted_password
    @bcrypt_pw = read_attribute(:encrypted_password)
    @bcrypt_pw.nil? ? nil : ::BCrypt::Password.new(@bcrypt_pw)
  end

  def password=(pw)
    @password = pw 
    self.encrypted_password = pw.nil? ? nil : ::BCrypt::Password.create(pw)
  end

  def self.authenticate(email, password)
    @u = User.first(email: email)
    @u && @u.encrypted_password == password ? @u : nil
  end



end
