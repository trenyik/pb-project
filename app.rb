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

    def self.create_table
        sql = <<-SQL
        CREATE TABLE IF NOT EXISTS users (
          id INTEGER PRIMARY KEY,
          name TEXT,
          image_url TEXT
        )
        SQL
        DB[:conn].execute(sql)
      end

      def save
        sql = <<-SQL
        INSERT INTO users (name, image_url)
        VALUES (?, ?)
        SQL
        DB[:conn].execute(sql, value1, value2)
        @id =DB[:conn].execute("SELECT last_insert_rowid()FROM users")[0][0]
      end
end