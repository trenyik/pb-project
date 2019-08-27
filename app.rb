require_relative "database-files.rb"
require "net/HTTP"
require "uri"
require "json"

class Application < Sinatra::Base
    attr_reader :image_url

    def initialize(app = nil)
        super(app)
        @image_url
        @totalHits
        @hits
        DB[:conn].execute("CREATE TABLE IF NOT EXISTS photos(id INTEGER PRIMARY KEY, views INTEGER, like INTEGER);")
        DB[:conn].execute("CREATE TABLE IF NOT EXISTS galleries(id INTEGER PRIMARY KEY, tags TEXT, name TEXT);")
        DB[:conn].execute("CREATE TABLE IF NOT EXISTS photos_to_galleries(id INTEGER PRIMARY KEY, photos_id INTEGER, galleries_id INTEGER);")
        galleries = DB[:conn].execute("SELECT id FROM galleries")
        galleries.each { |gallery|
            Gallery.new(gallery[0])
        }

    end

    get '/index' do
        erb :'/index'

    end

    get '/gallery' do
        
        @hits = fetch("flowers+summer")
        if @hits["totalHits"] == 0
            @image_url = "No Results Found With Current Tags"
        else
            @image_url = @hits["hits"][0]["webformatURL"]
        end
        erb :'/gallery'

    end

    post "/gallery" do
        puts params["usrname"]
        erb :'/index'
    end

    def fetch(tags)
        key = ENV["PIXABAY_API_KEY"]
        request = URI("https://pixabay.com/api/?key=#{key}&q=#{tags}&image_type=photo")
        response = Net::HTTP.get_response(request)
        JSON.parse(response.body)
    end
end