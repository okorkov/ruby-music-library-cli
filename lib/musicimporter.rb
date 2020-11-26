class MusicImporter

    attr_reader :path

    def initialize(path)
        @path = path
    end

    def path
        @path
    end

    def files
        Dir.entries(@path).select { |f| File.file? File.join(@path, f) }
    end

    def import 
        array = self.files
        array.each do |song|
            Song.create_from_filename(song)
        end
    end

end