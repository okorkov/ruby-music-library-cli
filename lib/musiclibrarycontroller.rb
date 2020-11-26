class MusicLibraryController

    attr_reader :path, :list_songs
    

    def initialize(path = './db/mp3s')
        @path = path
        @mi = MusicImporter.new(path)
        @mi.import
        @all_songs_display = Song.all.sort! { |a, b|  a.name <=> b.name }
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        @input = gets.chomp
        @commands = ['list songs', 'list artists', 'list artists', 'list genres', 'list artist', 'list genre', 'play song']
        if @input != "exit".downcase && @commands.include?(@input) == false
            call
        elsif @input == "list songs"
            list_songs
        elsif @input == 'list artists'
            list_artists
        elsif @input == 'list genres'
            list_genres
        elsif @input == 'list artist'
            list_songs_by_artist
        elsif @input == 'list genre'
            list_songs_by_genre
        elsif @input == 'play song'
            play_song
        end
        
    end

    def list_songs
        @all_songs = Song.all
        @all_songs.sort! { |a, b|  a.name <=> b.name }
        counter = 1
        @all_songs.each do |song|
            puts "#{counter}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
            counter +=1
        end
    end

    def list_artists
        all_artists = Artist.all
        all_artists.sort! { |a, b|  a.name <=> b.name }
        counter = 1
        all_artists.each do |artist|
            puts "#{counter}. #{artist.name}"
            counter +=1
        end
    end

    def list_genres
        all_genre = Genre.all
        all_genre.sort! { |a, b|  a.name <=> b.name }
        counter = 1
        all_genre.each do |genre|
            puts "#{counter}. #{genre.name}"
            counter +=1
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        @input_artist_name = gets.chomp
        @artist_instance = nil
        Artist.all.each {|artist| @artist_instance = artist if @input_artist_name == artist.name}
        @array_of_songs = []
        Song.all.each do |song|
            @array_of_songs << song if song.artist == @artist_instance
        end
        @array_of_songs.sort! { |a, b|  a.name <=> b.name }
        counter = 1
        @array_of_songs.each do |song|
            puts "#{counter}. #{song.name} - #{song.genre.name}"
            counter += 1
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        @input_genre_name = gets.chomp
        @genre_instance = nil
        Genre.all.each {|genre| @genre_instance = genre if @input_genre_name == genre.name}
        @array_of_songs = []
        Song.all.each do |song|
            @array_of_songs << song if song.genre == @genre_instance
        end
        @array_of_songs.sort! { |a, b|  a.name <=> b.name }
        counter = 1
        @array_of_songs.each do |song|
            puts "#{counter}. #{song.artist.name} - #{song.name}"
            counter += 1
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        play_song_input = gets.chomp
        if  play_song_input.to_i > 0 && play_song_input.to_i < Song.all.length
            puts "Playing #{@all_songs_display[play_song_input.to_i - 1].name} by #{@all_songs_display[play_song_input.to_i - 1].artist.name}"
        end
    end
        
end