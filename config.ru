require 'sinatra'
require 'sqlite3'

require_relative './app.rb'
DB = {:conn => SQLite3::Database.new("pixabay-db.db")}

run Application