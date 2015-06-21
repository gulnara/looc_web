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

# Implement your Warden stratagey to validate and authorize the access_token.
Warden::Strategies.add(:access_token) do
    def valid?
        # Validate that the access token is properly formatted.
        # Currently only checks that it's actually a string.
        request.env["HTTP_ACCESS_TOKEN"].is_a?(String)
    end

    def authenticate!
        # Authorize request if HTTP_ACCESS_TOKEN matches 'youhavenoprivacyandnosecrets'
        # Your actual access token should be generated using one of the several great libraries
        # for this purpose and stored in a database, this is just to show how Warden should be
        # set up.
        access_granted = (request.env["HTTP_ACCESS_TOKEN"] == 'youhavenoprivacyandnosecrets')
        !access_granted ? fail!("Could not log in") : success!(access_granted)
    end
end


class Looc < Sinatra::Base



  enable :sessions
  register Sinatra::Flash
  set :session_secret, "supersecret"

  use Warden::Manager do |manager|
    manager.default_strategies :password, :access_token
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
    env['warden'].authenticate!(:password)

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
    env['warden'].authenticate!(:password)
    @user = current_user
    erb :form
  end

  post '/form' do
    env['warden'].authenticate!(:password)
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
		env['warden'].authenticate!(:password)
  	erb :thank_you
  end

  get '/sushi.json' do
    env['warden'].authenticate!(:access_token)
    content_type :json
    return {:sushi => ["Maguro", "Hamachi", "Uni", "Saba", "Ebi", "Sake", "Tai"]}.to_json
  end

end






