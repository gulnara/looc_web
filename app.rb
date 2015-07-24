require 'sinatra'
require 'mongo'
require 'mongo_mapper'
require 'uri'
require 'json'
require 'warden'
require 'sinatra/flash'
require 'aws-sdk'
require 'jwt'

include Mongo

mongo_url = ENV['MONGOLAB_URI'] || 'mongodb://localhost/looc'
 
MongoMapper.connection = Mongo::Connection.from_uri mongo_url
MongoMapper.database = URI.parse(mongo_url).path.gsub(/^\//, '') 
require './models/user'
require './models/data'
require './helpers/warden_helpers'
require './helpers/upload_helpers'

include WardenHelpers
include UploadHelpers

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


Warden::Strategies.add(:access_token) do
    def valid?
        request.env["HTTP_ACCESS_TOKEN"].is_a?(String)
    end

    # ToDo add logic to dycript the token

    def authenticate!
        vars = JWT.decode(request.env["HTTP_ACCESS_TOKEN"], ENV['SECRET_TOKEN']) rescue 'Invalid token' 
        access_granted = (vars[0]["user_id"]==ENV['ADMIN_ID'])
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
      redirect '/upload_img'
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
    @img_url = session["img_url"]
    erb :form
  end

  post '/form' do
    env['warden'].authenticate!(:password)
    if params.length < 45
      flash[:fail] = "You didn't fill all the fields"
      redirect '/form'
    else
  	  data = PicData.new({
  	   :pic_name => params[:pic_name], 
  		 :main_categories => params[:main_categories], 
  	   :sub_categories => params[:sub_categories],
  	   :pic_url => session["img_url"], 
  	   :question0 => {
          :Q => params[:question_1],
          :CorrectAnswer => params[:inlineRadioOptions1].to_i,
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
          :CorrectAnswer => params[:inlineRadioOptions2].to_i,
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
          :CorrectAnswer => params[:inlineRadioOptions3].to_i,
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
          :CorrectAnswer => params[:inlineRadioOptions4].to_i,
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
          :CorrectAnswer => params[:inlineRadioOptions5].to_i,
          :A => [
              params[:q_5_a_1],
              params[:q_5_a_2],
              params[:q_5_a_3],
              params[:q_5_a_4],
              params[:q_5_a_5]
          ]
      },
        :question5 => {
          :Q => params[:question_6],
          :CorrectAnswer => params[:inlineRadioOptions6].to_i,
          :A => [
              params[:q_6_a_1],
              params[:q_6_a_2],
              params[:q_6_a_3],
              params[:q_6_a_4],
              params[:q_6_a_5]
          ]
      }
  		})
  		data.save
      session["img_url"] = nil 
  	  redirect '/submitted'
    end
  end

  get '/upload_img' do
    env['warden'].authenticate!(:password)
    erb :upload_img
  end

  post '/upload' do
    env['warden'].authenticate!(:password)
    url = upload(params[:content]['file'][:filename], params[:content]['file'][:tempfile])
    session["img_url"] = url
    redirect '/form'
  end

  get '/submitted' do
		env['warden'].authenticate!(:password)
  	erb :thank_you
  end

  # API call to get questions for a specific category
  get '/data/:category' do
    env['warden'].authenticate!(:access_token)
    category = params[:category]
    all_data = PicData.all
    data = all_data.select{|a| a.main_categories.include? category}
    content_type :json
    return {:data => data}.to_json
  end

  # API call to get count of how many questions in each category
  get '/count' do
    env['warden'].authenticate!(:access_token)
    all_data = PicData.all
    count = {}
    all_data.each do |question|
      question.main_categories.each do |category|
        if count.include?(category)
          count[category] += 1
        else
          count[category] = 1
        end
      end
    end
    content_type :json
    return {:count => count}.to_json
  end

  # API call to get random 6 categories with a single question in each
  # Algorith will be much faster if we allowed only one main category
  get '/random' do
    # env['warden'].authenticate!(:access_token)
    random_data = []
    categories = []
    temp = 0
    while temp < 5 do 
      rand = Random.rand(0..(PicData.count-1))
      r = PicData.skip(rand).first
      item_categories = r.main_categories
      unique = item_categories-categories
      if !unique.empty?
        temp += 1
        random_data << r
      else
        puts "This category has been already selected"
      end
    end
    content_type :json
    return {:random_data => random_data}.to_json
  end

end
