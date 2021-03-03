class Genre

    extend Concerns::Findable
    
    attr_accessor :name
    #attr_reader :name
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
        all.clear
    end

    def self.create(name)
        new(name).save
    end

    def songs
        Song.all.select{|song| song.genre == self}
    end

    def genre=(genre) #writer method for genre
        @genre = genre
    end

    def artists
        Artist.all.select{|artist| artist.genre == self}
    end

    def artists
        songs.collect {|songss| songss.artist }.uniq
    end
end