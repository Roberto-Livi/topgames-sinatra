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
    if Helpers.is_logged_in?(session)
      user = Helpers.current_user(session)
      params[:user_id] = user.id
      redirect "/users_games_selection/#{user.id}"
    else
      erb :welcome
    end
  end

  get '/index' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      params[:user_id] = @user.id
      @games = Game.all

      erb :"/index"
    else
      redirect "/login"
    end
  end

  delete '/logout' do
    if Helpers.is_logged_in?(session)
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end


end
