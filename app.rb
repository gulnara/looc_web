require 'sinatra'
require 'mongo'
require 'mongo_mapper'
require 'uri'
require 'json'

include Mongo

mongo_url = ENV['MONGOLAB_URI'] || 'mongodb://localhost/looc'
 
MongoMapper.connection = Mongo::Connection.from_uri mongo_url
MongoMapper.database = URI.parse(mongo_url).path.gsub(/^\//, '') 
require './models/user'


get '/' do
  erb :"home"
end

post '/'do
  @user = User.find_by_email(params[:email])
  if @user.password == params[:password]
    give_token
  else
    redirect '/form'
  end

end


get '/form' do
  erb :"form"
end

