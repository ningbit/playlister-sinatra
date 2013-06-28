require 'sinatra/base'
require 'debugger'
require 'youtube_search'
require_relative './lib/models/artist.rb'
require_relative './lib/models/genre.rb'
require_relative './lib/models/song.rb'
require_relative './lib/models/library_parser.rb'

class PlaylisterApp < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @artists = Artist.all.sample(10)
    @songs = Song.all.sample(10)
    @song = Song.random
    erb :'/home'
  end

    get '/home' do
    @artists = Artist.all.sample(10)
    @songs = Song.all.sample(10)
    @song = Song.random
    erb :'/home'
  end

  get '/artists' do
    @artists = Artist.all.sort_by {|e| e.name}
    erb :'/artists/artists'
  end

  get '/search' do
    @search = params[:search]
    @artists = Artist.search_by_first_char(@search)
    @songs = Song.search_by_first_char(@search)
    @artists.concat Artist.search_by_string(@search) if @search.size > 1
    @songs.concat Song.search_by_string(@search) if @search.size > 1
    erb :'/search'
  end

  get '/random' do
    @song = Song.random
    erb :'/songs/song'
  end

  get '/artists/add' do
    erb :'/edit/add'
  end

  get '/artists/drop' do
    @artists = Artist.all
    erb :'/edit/drop'
  end

  get '/artists/:name/drop' do
    @artist = Artist.find_by_name(params[:name].gsub("_"," "))
    erb :'/edit/drop_confirmation'
  end

  get '/artists/:name/add' do
    @artist = Artist.find_by_name(params[:name].gsub("_"," "))
    erb :'/edit/add_song_artist'
  end

  get '/songs/:name/drop' do
    @song = Song.find_by_name(params[:name].gsub("_"," "))
    erb :'/edit/drop_song_confirmation'
  end

  get '/songs/add' do
    @artists = Artist.all
    erb :'/edit/add_song'
  end

  get '/songs/drop' do
    @songs = Song.all
    erb :'/edit/drop_song'
  end

  get '/drop/artists/:name' do
    Artist.delete(Artist.find_by_name(params[:name].gsub("_"," ")))
    @artists = Artist.all
    erb :'/artists/artists'
  end

  get '/drop/songs/:name' do
    Song.delete(Song.find_by_name(params[:name].gsub("_"," ")))
    @songs = Song.all
    erb :'/songs/songs'
  end

  post '/edit/confirmation' do
    if params[:name].size != 0
      if Artist.find_by_name(params[:name])
        artist = Artist.find_by_name(params[:name])
        @artist_exist = true
      else
        artist = Artist.new
        @artist_exist = false
      end
      artist.name ||= params[:name]
      if params[:song].size != 0
        song = Song.new
        genre = Genre.find_by_name(params[:genre])
        song.name = params[:song]
        song.genre = genre
        artist.add_song(song)
        @new_song = song
      end
      @artist = artist
    else
      @artist = nil
    end
    erb :'/edit/confirmation'
  end

  post '/edit/song_confirmation' do
    artist = Artist.find_by_name(params[:name])
    if params[:song].size != 0
      song = Song.new
      genre = Genre.find_by_name(params[:genre])
      artist.name = params[:name]
      song.name = params[:song]
      song.genre = genre
      artist.add_song(song)
      @new_song = song
      @artist = artist
    else
      @artist = nil
    end
    erb :'/edit/song_confirmation'
  end

  get '/artists/:name' do
    @artist = Artist.find_by_name(params[:name].gsub("_"," "))
    erb :'/artists/artist'
  end

  get '/songs' do
    @songs = Song.all.sort_by { |e| e.name }
    erb :'/songs/songs'
  end

  get '/songs/:name' do
    song_name = params[:name]
    @song = Song.find_by_name(params[:name].split("_-_").last.gsub("_"," "))
    erb :'/songs/song'
  end

  get '/genres' do
    @genres = Genre.all
    erb :'/genres/genres'
  end

  get '/genres/:name' do
    @genre = Genre.find_by_name(params[:name].gsub("_"," "))
    erb :'/genres/genre'
  end

  post '/edit/genre_confirmation' do
    if !Genre.find_by_name(params[:genre].downcase.gsub("_"," "))
      @genre = Genre.new
      @genre.name = params[:genre].downcase.gsub("_"," ")
    end
    erb :'/edit/genre_confirmation'
  end

end