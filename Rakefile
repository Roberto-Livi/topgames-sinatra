require "bundler/gem_tasks"
task :default => :spec

ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'
