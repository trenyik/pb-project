require_relative "database-files.rb"

class Application < Sinatra::Base
    attr_reader :image_url

    def initialize(app = nil)
        super(app)
        
    end

    get '/index'do
        erb :'/index'

    end

    get '/gallery' do
        erb :'/gallery'
        
    end
end