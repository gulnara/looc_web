require 'sinatra'
require 'mongo'
require 'mongo_mapper'
require 'uri'
require 'json'

include Mongo

mongo_url = ENV['MONGOLAB_URI'] || 'mongodb://localhost/dbname'
 
MongoMapper.connection = Mongo::Connection.from_uri mongo_url
MongoMapper.database = URI.parse(mongo_url).path.gsub(/^\//, '') #Extracts 'dbname' from the uri
require './models/user'


get '/' do
  erb :"home"
end


get '/form' do
  erb :"form"
end