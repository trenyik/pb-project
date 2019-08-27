class Gallery
    @@galleries = []

    def initialize(id)
        sql = <<- SQL
            SELECT photos.id 
            FROM photos 
            JOIN photos_to_galleries 
            ON photos.id = photos_to_galleries.photos_id
            JOIN galleries
            ON galleries.id = photos_to_galleries.galleries_id
            WHERE photos_to_galleries.galleries_id = ?;
        SQL
        @photos_id = DB[:conn].execute(sql, id)
        @@galleries << self
    end

    def self.create_gallery(tags:, name:)
        DB[:conn].execute("INSERT INTO galleries(tags, name) VALUES(?, ?)", tags, name)
        id = DB[:conn].execute("SELECT last_insert_rowid() FROM galleries")[0][0]
        hits = fetch(tags)
        unless hits["totalHits"] == 0
            hits["hits"][0..19].each { |hit|
                photo = ""
                photo = DB[:conn].execute("SELECT id FROM photos WHERE image_url = ?", hit["image_url"])
                if !photo.empty?
                    DB[:conn].execute("INSERT INTO photos(views, likes, image_url)")
                    photo = DB[:conn].execute("SELECT last_insert_rowid() FROM galleries")[0][0]
                end
                DB[:conn].execute("INSERT INTO photos_to_galleries(photos_id, galleries_id VALUES(?, ?)", photo[0], id)
            }
        end
        Gallery.new(id)
    end
end