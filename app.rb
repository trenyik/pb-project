class Application < Sinatra::Base

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