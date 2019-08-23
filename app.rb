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
    end

    get '/index'do
        erb :'/index'

    end

    get '/gallery' do\
        @hits = fetch("flowers+summer")
        if @hits["totalHits"] == 0
            @image_url = "No Results Found With Current Tags"
        else
            @image_url = @hits["hits"][0]["webformatURL"]
        end
        erb :'/gallery'

    end

    def fetch(tags)
        key = ENV["PIXABAY_API_KEY"]
        request = URI("https://pixabay.com/api/?key=#{key}&q=#{tags}&image_type=photo")
        response = Net::HTTP.get_response(request)
        JSON.parse(response.body)
    end
end