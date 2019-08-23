class User
    attr_accessor :name, :url
    attr_reader :id

    def initialize(name, url)
        @name = name
        @url = url
        @id = nil
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
        DB[:conn].execute(sql, @name, @url)
        @id =DB[:conn].execute("SELECT last_insert_rowid()FROM users")[0][0]
    end
end


class Photos

    def initialize(height, width, views, likes, user_id)
        @height = height
        @width = width
        @view = views
        @likes = likes
        @id = nil
        @user_id = user_id
    end

    def self.create_photos_table
        sql = <<-SQL
        CREATE TABLE IF NOT EXISTS photos (
            id INTEGER PRIMARY KEY,
            height INTEGER,
            width INTEGER,
            views INTEGER,
            likes INTEGER,
            user_id INTEGER
        )
        SQL
        DB[:conn].execute(sql)
    end

    def save
        sql = <<-SQL
        INSERT INTO users (height, width, views, likes, user_id)
        VALUES (?, ?, ?, ?, ?)
        SQL
        DB[:conn].execute(sql, @height, @width, @view, @likes, @user_id)
        @id =DB[:conn].execute("SELECT last_insert_rowid()FROM users")[0][0]
    end
end