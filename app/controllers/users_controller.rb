class UsersController < ApplicationController

  get '/signup' do
    if Helpers.is_logged_in?(session)
      user = Helpers.current_user(session)
      params[:user_id] = user.id

      redirect "/users_games_selection/#{user.id}"
    else
      erb :"/user/signup"
    end
  end

  post '/signup' do
    params.each do |key, value|
      if value.empty?
        flash[:sign_up_error] = "One or more sections were empty"
        redirect "/signup"
      end
    end

    user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    session[:user_id] = user.id

    redirect "/users_games_selection/#{user.id}"
  end

    get '/login' do
      if Helpers.is_logged_in?(session)
        user = Helpers.current_user(session)
        params[:user_id] = user.id

        redirect "/users_games_selection/#{user.id}"
      else
        erb :"/user/login"
    end
  end

    post '/login' do
      user = User.find_by(:username => params[:username])

      if user && user.authenticate(params[:password])
        session[:user_id] = user.id

        redirect "/users_games_selection/#{user.id}"
      else
        flash[:login_error] = "Wrong username or password"
        redirect "/login"
      end
    end

end