require 'sinatra'
require 'mongo'
require 'mongo_mapper'
require 'uri'
require 'json'
require 'warden'
require 'sinatra/flash'


include Mongo

mongo_url = ENV['MONGOLAB_URI'] || 'mongodb://localhost/looc'
 
MongoMapper.connection = Mongo::Connection.from_uri mongo_url
MongoMapper.database = URI.parse(mongo_url).path.gsub(/^\//, '') 
require './models/user'


Warden::Strategies.add(:password) do
  def valid?
    params['user'] && params[:email] && params[:password]
  end

  def authenticate!
    user = User.first(email: params[:email])

    if user.nil?
      throw(:warden, message: "The username you entered does not exist.")
    elsif user.authenticate(params[:password])
      success!(user)
    else
      throw(:warden, message: "The username and password combination ")
    end
  end
end

enable :sessions
register Sinatra::Flash
set :session_secret, "supersecret"

use Warden::Manager do |config|
  # Tell Warden how to save our User info into a session.
  # Sessions can only take strings, not Ruby code, we'll store
  # the User's `id`
  config.serialize_into_session{|user| user.id }
  # Now tell Warden how to take what we've stored in the session
  # and get a User from that information.
  config.serialize_from_session{|id| User.get(id) }

  config.scope_defaults :default,
    # "strategies" is an array of named methods with which to
    # attempt authentication. We have to define this later.
    strategies: [:password],
    # The action is a route to send the user to when
    # warden.authenticate! returns a false answer. We'll show
    # this route below.
    action: 'unauthenticated'
  # When a user tries to log in and cannot, this specifies the
  # app to send the user to.
  config.failure_app = self
end

Warden::Manager.before_failure do |env,opts|
  env['REQUEST_METHOD'] = 'POST'
end

get '/' do
  erb :"home"
end


post '/' do
  env['warden'].authenticate!

  flash[:success] = env['warden'].message

  if session[:return_to].nil?
    redirect '/form'
  else
    redirect session[:return_to]
  end
end

get '/logout' do
  env['warden'].raw_session.inspect
  env['warden'].logout
  flash[:success] = 'Successfully logged out'
  redirect '/'
end

post '/unauthenticated' do
  session[:return_to] = env['warden.options'][:attempted_path] if session[:return_to].nil?

  # Set the error and use a fallback if the message is not defined
  flash[:error] = env['warden.options'][:message] || "You must log in"
  redirect '/'
end

get '/form' do
  env['warden'].authenticate!

  erb :"form"
end



# post '/'do
#   @user = User.find_by_email(params[:email])
#   if @user.password == params[:password]
#     give_token
#   else
#     redirect '/form'
#   end

# end


# get '/form' do
#   erb :"form"
# end

