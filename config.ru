require 'sinatra'

require_relative './app.rb'
DB = {:conn => SQLite3::Database.new("db/students.db")}

run Application