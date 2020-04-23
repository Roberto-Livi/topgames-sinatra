class TestingController < ApplicationController

    get '/testing' do
        @users = User.all
        @games = Game.all
        erb :"user/testing"
    end

end