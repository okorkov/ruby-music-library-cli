class Song

    include Concerns::Instance_methods
    extend Concerns::Class_methods
    extend Concerns::Findable

    @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        if artist != nil
            self.artist= artist
        end
        if genre != nil
            self.genre= genre
        end
    end

    def self.all
        @@all
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.add_song(self)
    end

    def self.create(name)
        n = Song.new(name)
        n.save
        n
    end

    def self.new_from_filename(file_name)
        song_splitted = file_name.split(/[-.]/)
        artist_name = song_splitted[0]
        artist_name = artist_name.split(' ').join(' ')
        song_name = song_splitted[1]
        song_name = song_name.split(' ').join(' ')
        genre = song_splitted[2]
        genre = genre.split(' ').join(' ')
        if genre == "hip"
            genre = "hip-hop"
        end
        art =  Artist.find_or_create_by_name(artist_name)
        gnr = Genre.find_or_create_by_name(genre)
        ns = Song.new(song_name)
        ns.artist = art
        ns.genre = gnr
        ns
    end

    def self.create_from_filename(file_name)
        nsc = self.new_from_filename(file_name)
        nsc.save
        nsc
    end

end