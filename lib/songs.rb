class Song
    
    attr_accessor :name
    attr_reader :artist, :genre #a song only has one artist. and only one genre.
   
    @@all = [] #class variable 

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist 
        self.genre = genre if genre # having save here was causing it to save twice
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
        #name = Song.new(new_song)
        new(name).save
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre     
    end

    def self.find_by_name(name)
        all.find {|song| song.name == name}
    end

    def self.find_or_create_by_name(name)
        find_by_name(name) ? find_by_name(name) : create(name)
    end

    def self.new_from_filename(song_filename) #song_filename arrives as "artist - title - genre.mp3"
        broken_filename = song_filename.split(/\.|\s-\s/) #make a temporary array with all three elements, parsing out the punctuation and whitespaces
        brk_artists_name = broken_filename[0] #first element in new array, which is the artist
        brk_song_name = broken_filename[1] #second element in new array, which is the title
        brk_genre = broken_filename[2] #third element, the genre
        new(brk_song_name, Artist.find_or_create_by_name(brk_artists_name), Genre.find_or_create_by_name(brk_genre))
        # we don't want to create duplicates of artists or genres
    end
  
    def self.create_from_filename(song_filename)
        new_from_filename(song_filename).save #lmao       
    end
end

