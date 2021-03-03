class Artist
    
    extend Concerns::Findable

    attr_accessor :name
    @@all = [] #class variable 

    def initialize(name)
        @name = name
    end

    def self.all
        @@all
    end

    def save
        self.class.all << self
        self
    end

    def self.destroy_all
        @@all.clear
    end

    def self.create(new_artist)
        new(new_artist).save
    end

    def songs
        Song.all.select {|song| song.artist == self}
    end

    def add_song(song)
        #if !song.artist
            song.artist = self unless song.artist
        #end
    end
    
    def name=(name)
        @name = name
    end

    def genres
        songs.collect {|songss| songss.genre }.uniq
    end
end