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
require './models/data'
require './helpers/warden_helpers'

include WardenHelpers


Warden::Strategies.add(:password) do
  def valid?
    params['email'] || params['password']
  end

  def authenticate!
      
    if user = User.authenticate(params['email'], params['password'])
    	puts "loged in "
      success!(user)
    else
    	puts "The username and password combination "
      throw(:warden, message: "The username and password combination ")
      fail!
    end
  end
end


class Looc < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  set :session_secret, "supersecret"

  use Warden::Manager do |manager|
    manager.default_strategies :password
    manager.failure_app = self
  end

  Warden::Manager.before_failure do |env,opts|
    env['REQUEST_METHOD'] = 'POST'
  end


  get '/' do
    erb :home
  end

  get '/auth/login' do
    erb :login
  end

  post '/auth/login' do
    env['warden'].authenticate!

    flash[:success] = env['warden'].message

    if session[:return_to].nil?
    	puts "you are loged in"
      redirect '/form'
    else
      redirect session[:return_to]
      puts "you are not loged in"
    end
  end

  get '/auth/logout' do
    env['warden'].raw_session.inspect
    env['warden'].logout
    flash[:success] = 'Successfully logged out'
    redirect '/'
  end

  post '/unauthenticated/?' do 
    erb :login
  end

  get '/form' do
    env['warden'].authenticate!
    @user = current_user
    erb :form
  end

  post '/form' do

    puts params[:main_category]
	 #  data = PicData.new({
	 #   :pic_name => params['pic_name'], 
		#  :main_categories => params["main_category"]["category_id"], 
	 #   :sub_categories => "sub categories",
	 #   :pic_url => "url for pic", 
	 #   :pic_question_id => params['question_id'],
	 #   :question0 => {
  #       :Q => "How many spoons had something in them?",
  #       :CorrectAnswer => 1,
  #       :A => [
  #           "Five",
  #           "Four",
  #           "Three",
  #           "None of them",
  #           "All of them"
  #       ]
  #   },
	 #   :question1 => {
  #       :Q => "How many spoons had something in them?",
  #       :CorrectAnswer => 2,
  #       :A => [
  #           "Five",
  #           "Four",
  #           "Three",
  #           "None of them",
  #           "All of them"
  #       ]
  #   },
	 #   :question2 => {
  #       :Q => "How many spoons had something in them?",
  #       :CorrectAnswer => 3,
  #       :A => [
  #           "Five",
  #           "Four",
  #           "Three",
  #           "None of them",
  #           "All of them"
  #       ]
  #   },
	 #   :question3 => {
  #       :Q => "How many spoons had something in them?",
  #       :CorrectAnswer => 4,
  #       :A => [
  #           "Five",
  #           "Four",
  #           "Three",
  #           "None of them",
  #           "All of them"
  #       ]
  #   },
	 #   :question4 => {
  #       :Q => "How many spoons had something in them?",
  #       :CorrectAnswer => 5,
  #       :A => [
  #           "Five",
  #           "Four",
  #           "Three",
  #           "None of them",
  #           "All of them"
  #       ]
  #   }
		# })
		# data.save
	 #  redirect '/submitted'
  end

  get '/submitted' do
		env['warden'].authenticate!
  	erb :thank_you
  end

end






