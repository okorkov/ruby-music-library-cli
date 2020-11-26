module Concerns
    module Instance_methods
        def name
            @name
        end

        def name=(name)
            @name = name
        end

        def artist
            @artist
        end

        def artist=(artist)
            @artist = artist
        end

        def genre
            @genre
        end

        def genre=(genre)
            @genre = genre
        end

        def save
            self.class.all << self
        end

        def songs
            @songs
        end

        def alphabetize
            self.songs.sort! { |a, b|  a.name <=> b.name }
        end

    end

    module Class_methods

        def destroy_all
            self.all.clear
        end

    end

    module Findable

        def find_by_name(song_name)
            found_song = nil
            self.all.each do |song|
                if song.name == song_name
                    found_song = song
                end
            end
            found_song
        end
    
        def find_or_create_by_name(song_name)
            if self.find_by_name(song_name) != nil
                self.find_by_name(song_name)
            else
                self.create(song_name)
            end
        end
    end

end