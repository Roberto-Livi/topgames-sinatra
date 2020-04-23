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

  get '/signup' do
    erb :"/user/signup"
  end

  post '/signup' do
    params.each do |key, value|
      if value.empty?
        redirect "/signup"
      end
    end

    user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    session[:user_id] = user.id
    redirect "/select_games"
  end

  get '/login' do
    erb :"/user/login"
  end

  post '/login' do
    redirect "/index"
  end

  get '/select_games' do
    @user = User.find_by(:username => params[:username])
    if Helpers.is_logged_in?(session)
      erb :"/user/register_fav_games"
    else
      redirect "/"
    end
  end

  post '/select_games' do
    user = Helpers.current_user(session)
    params[:user_id] = user.id
    if params[:first_game].empty? && params[:second_game].empty? && params[:third_game].empty? && params[:fourth_game].empty? && params[:fifth_game].empty?
      redirect "/select_games"
    else
      @game_one = Game.create(:name => params[:first_game], :user_id => params[:user_id])
      @game_two = Game.create(:name => params[:second_game], :user_id => params[:user_id])
      @game_three = Game.create(:name => params[:third_game], :user_id => params[:user_id])
      @game_four = Game.create(:name => params[:fourth_game], :user_id => params[:user_id])
      @game_five = Game.create(:name => params[:fifth_game], :user_id => params[:user_id])

      erb :"/user/users_games_selection"
    end
  end


end
