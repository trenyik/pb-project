require_relative "database-files.rb"

class Application < Sinatra::Base

    def initialize(app = nil)
        super(app)

    end

    get '/index'do
        erb :'/index'
    end

    get '/gallery' do
        erb :'/gallery'
        DB[:conn].execute(sql)
    end
end