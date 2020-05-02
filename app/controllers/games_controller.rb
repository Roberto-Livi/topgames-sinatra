class GamesController < ApplicationController

get '/select_games' do

@user = User.find_by(:username => params[:username])
  if Helpers.is_logged_in?(session)
    erb :"/games/register_fav_games"
  else
    redirect "/"
  end
end

post '/select_games' do

@user = Helpers.current_user(session)
params[:user_id] = @user.id

  params.each do |key, value|
    if value.empty?
        flash[:post_error] = "Post couldn't be created. One or more fields were empty"
        redirect "/users_games_selection/#{@user.id}"
    else
      game = Game.create(:first_game => params[:first_game], :second_game => params[:second_game], :third_game => params[:third_game], :fourth_game => params[:fourth_game], :fifth_game => params[:fifth_game], :user_id => params[:user_id], :list_name => params[:list_name])

      redirect "/users_games_selection/#{@user.id}"
    end
  end
end

get '/new_games_list' do
  if Helpers.is_logged_in?(session)
    erb :"/games/new_game_list"
  else
    redirect "/login"
  end
end

post '/new_games_list' do
  params.each do |key, value|
    if value.empty?
      flash[:new_list_error] = "One or more fields were empty"
      redirect "/new_games_list"
    end
  end

@user = Helpers.current_user(session)
params[:user_id] = @user.id

new_list = Game.create(:first_game => params[:first_game], :second_game => params[:second_game], :third_game => params[:third_game], :fourth_game => params[:fourth_game], :fifth_game => params[:fifth_game], :user_id => params[:user_id], :list_name => params[:list_name])
@user.games << new_list

redirect "/users_games_selection/#{@user.id}"

end

get '/users_games_selection/:id' do
  @user = Helpers.current_user(session)
  params[:user_id] = @user.id
  if Helpers.is_logged_in?(session)
    erb :"/games/users_games_selection"
  else
    redirect "/login"
  end
end

get '/games/:id/update' do
  if Helpers.is_logged_in?(session)
    @games = Game.find(params[:id])
    if Helpers.current_user(session).id == @games.user_id
    else
      redirect "/index"
    end
    erb :"/games/update_games_list"
  else
    redirect "/"
    end
end

patch '/users_games_selection/:id' do
  games = Game.find(params[:id])
  params.each do |key, value|
    if value.empty?
      flash[:update_error] = "One or more fields were empty"
      redirect "/games/#{games.id}/update"
    end
  end

  games.update(:first_game => params[:first_game], :second_game => params[:second_game], :third_game => params[:third_game], :fourth_game => params[:fourth_game], :fifth_game => params[:fifth_game], :list_name => params[:list_name])
    games.save

  redirect "/users_games_selection/#{games.id}"
end

post '/games/:id/delete' do
  if Helpers.is_logged_in?(session)
    user = Helpers.current_user(session)
    params[:user_id] = user.id
    game = Game.find(params[:id])
    game.destroy

    redirect "/users_games_selection/#{user.id}"
  else
    redirect "/login"
  end
end


end