class Genre

    include Concerns::Instance_methods
    extend Concerns::Class_methods
    extend Concerns::Findable

    @@all = []

    def initialize(genre)
        @name = genre
        @songs = []
    end

    def self.all
        @@all
    end

    def artists
        result = []
        @songs.each do |song|
            result << song.artist
        end
        result.uniq
    end

    def self.create(name)
        n = Genre.new(name)
        n.save
        n
    end

    def add_song(song)
        if song.genre == nil
            song.genre = self
        end
        if @songs.include?(song) == false
            @songs << song
        end
    end

end