require 'mongo'
require 'mongo_mapper'

class User
	include MongoMapper::Document

	key :user_id, Integer, :required => true
	key :created_at, Time, :required => true
	key :email, String, :required => true
	key :name, String, :required => true
	key :password, String, :required => true


end

User.ensure_index [[:user_id, 1]], :unique => true
