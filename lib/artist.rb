class Artist

    include Concerns::Instance_methods
    extend Concerns::Class_methods
    extend Concerns::Findable

    @@all = []

    def initialize(name)
        @name = name
        @songs = []
    end

    def self.all
        @@all
    end

    def self.create(name)
        n = Artist.new(name)
        n.save
        n
    end

    def genres
        result = []
        @songs.each do |song|
            result << song.genre 
        end
        result.uniq
    end

    def add_song(song)
        if song.artist == nil
            song.artist = self
        end
        if @songs.include?(song) == false
            @songs << song
        end
    end

end