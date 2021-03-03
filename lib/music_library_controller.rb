require 'pry'
class MusicLibraryController
    INPUTS = ["list songs", "list artists", "list genres", "list artist", "list genre", "play song", "exit"]
    extend Concerns::Findable
    
    def initialize(path = "./db/mp3s")
        MusicImporter.new(path).import #when initialized, creates instance of MusicImporter with the path and runs import on it
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
        input = gets.strip # must take input from user
        if !INPUTS.include?(input) #if the input isn't one of the acceptable ones, ask for a new input
            call
            elsif input == "list songs"
                list_songs
            elsif input == "list artists"
                list_artists
            elsif input == "list genres"
                list_genres
            elsif input == "list artist"
                list_songs_by_artist
            elsif input == "list genre"
                list_songs_by_genre
            elsif input == "play song"
                play_song
            end
        end
    # end

    def list_songs
        #sorted = 
        Song.all.sort{|song_a, song_b| song_a.name <=> song_b.name}.each.with_index do |song, position| #rocketship compares
            puts "#{position + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end        
    end

    def list_artists
        Artist.all.sort{|artist_a, artist_b| artist_a.name <=> artist_b.name}.each.with_index do |artist, position|
            puts "#{position + 1}. #{artist.name}"
        end
    end

    def list_genres
        Genre.all.sort{|genre_a, genre_b| genre_a.name <=> genre_b.name}.each.with_index do |genre, position|
            puts "#{position + 1}. #{genre.name}"
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.strip
        if artist = Artist.find_by_name(input)
            artist.songs.sort{|song_a, song_b| song_a.name <=> song_b.name}.each.with_index do |song, position|
                puts "#{position + 1}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.strip
        if genre = Genre.find_by_name(input)
            genre.songs.sort{|song_a, song_b| song_a.name <=> song_b.name}.each.with_index do |song, position|
                puts "#{position + 1}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        input = gets.strip.to_i
        puts "Playing #{Song.all[input].name} by #{Song.all[input].artist.name}" unless !Song.all[input] || !input.between?(1, Song.all.length)
    end
   
end