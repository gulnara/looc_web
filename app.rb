require 'sinatra'

get '/' do
  erb :"home"
end


get '/form' do
  erb :"form"
end