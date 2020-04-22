require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  enable :sessions
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "secret"
  end

  get "/" do
    erb :welcome
  end

  get '/index' do
    erb :"/user/index"
  end

  get '/login' do
    erb :"/user/login"
  end

  post '/login' do
    redirect "/index"
  end

  get '/signup' do
    erb :"/user/signup"
  end

end
