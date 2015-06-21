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

	  data = PicData.new({
	   :pic_name => params[:pic_name], 
		 :main_categories => params[:main_categories], 
	   :sub_categories => params[:sub_categories],
	   :pic_url => "url for pic", 
	   :pic_question_id => params[:question_id],
	   :question0 => {
        :Q => params[:question_1],
        :CorrectAnswer => params[:inlineRadioOptions1],
        :A => [
            params[:q_1_a_1],
            params[:q_1_a_2],
            params[:q_1_a_3],
            params[:q_1_a_4],
            params[:q_1_a_5]
        ]
    },
	   :question1 => {
        :Q => params[:question_2],
        :CorrectAnswer => params[:inlineRadioOptions2],
        :A => [
            params[:q_2_a_1],
            params[:q_2_a_2],
            params[:q_2_a_3],
            params[:q_2_a_4],
            params[:q_2_a_5]
        ]
    },
	   :question2 => {
        :Q => params[:question_3],
        :CorrectAnswer => params[:inlineRadioOptions3],
        :A => [
            params[:q_3_a_1],
            params[:q_3_a_2],
            params[:q_3_a_3],
            params[:q_3_a_4],
            params[:q_3_a_5]
        ]
    },
	   :question3 => {
        :Q => params[:question_4],
        :CorrectAnswer => params[:inlineRadioOptions4],
        :A => [
            params[:q_4_a_1],
            params[:q_4_a_2],
            params[:q_4_a_3],
            params[:q_4_a_4],
            params[:q_4_a_5]
        ]
    },
	   :question4 => {
        :Q => params[:question_5],
        :CorrectAnswer => params[:inlineRadioOptions5],
        :A => [
            params[:q_5_a_1],
            params[:q_5_a_2],
            params[:q_5_a_3],
            params[:q_5_a_4],
            params[:q_5_a_5]
        ]
    }
		})
		data.save
	  redirect '/submitted'
  end

  get '/submitted' do
		env['warden'].authenticate!
  	erb :thank_you
  end

end






