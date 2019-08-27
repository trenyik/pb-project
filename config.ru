require 'sinatra'
require 'sqlite3'

require_relative './app.rb'

DB[:conn].execute("CREATE TABLE IF NOT EXISTS photos(id INTEGER PRIMARY KEY, views INTEGER, like INTEGER);")
DB[:conn].execute("CREATE TABLE IF NOT EXISTS galleries(id INTEGER PRIMARY KEY, tags TEXT, name TEXT);")
DB[:conn].execute("CREATE TABLE IF NOT EXISTS photos_to_galleries(id INTEGER PRIMARY KEY, photos_id INTEGER, galleries_id INTEGER);")


run Application